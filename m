Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF1512AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 06:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiD1EoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 00:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiD1EoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:44:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90F6F9EE;
        Wed, 27 Apr 2022 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uM1vzjLNlE95JQocn/nz/Er8oPB+RbA0CKE85l/zVYs=; b=iXPyNU3I1rF1Xzo5duZjSTEIUd
        3RgDe44EjoE8c8sKe/jRGjObd8rI4z3rLU60G/ktOYjq38XMn1L2DNsE9CcRZOXzduG1mhKNGZC7h
        wfkqETUlGfcYaLFO+q5boUL2+ivtalOZJbxt/RUw5eslP30xZRFudQO5jFInma/BQG5V5V2PQ9EOT
        uB/EHCmnTuJrpTUM8WlMk8xCNLv+88e9b0GVgrVuqFJlaZ8+dpN/gDtdYaY2fkj1JqQIGidTwvv89
        lSAhVlpyfFOMPAdte0ZZnVV7vgT4JjEjkXI/Ll6pV1ayl+iSxwqIy41sNL36ZdFFCJW3tYDQWg1p2
        EE/+LMkQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njvxO-00A7u0-Vf; Thu, 28 Apr 2022 04:40:47 +0000
Date:   Thu, 28 Apr 2022 04:40:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        david@fromorbit.com, djwong@kernel.org, brauner@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <YmoazgJtASSYhYk/@zeniv-ca.linux.org.uk>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:11:27PM +0800, Yang Xu wrote:


> +umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
> +			 const struct inode *dir, umode_t mode)
> +{
> +	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
> +		return mode;
> +	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> +		return mode;
> +	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
> +		return mode;
> +	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> +		return mode;
> +
> +	mode &= ~S_ISGID;
> +	return mode;
> +}

	I'm fairly sure that absolute majority of calls will not
have S_ISGID passed in mode.  So I'd prefer to reorder the first
two ifs.
