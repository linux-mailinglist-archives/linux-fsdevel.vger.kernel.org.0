Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72366A7CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjANA5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjANA5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:57:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB606084B;
        Fri, 13 Jan 2023 16:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rd3Vj9lLZkTiTcTgWc40nMIxJu0kY5xaOD5YAF6BsVI=; b=LLYxhsZxvWu+2FiMz0POAm3zf4
        rIvG+7CscM+aZvZNawZpNKl1LEKpNv8yMKia38YrbP7vpTIVHrDe6Qy/yyiiHOVUDVHdvAV4zuXZP
        LJOWA7ag+O2cXPJCKV2oci5TZNbSqXWj/5o0rIirYT+bvMM86GC28bT7Cp61rQTwlJtjbaFlGm/xb
        Tw8Y9YoRtt8WyMqwc75JNbCIPIJWLvRB4kqvrZQ5xaau8bq+rFpGsSDUyw0b5nRS+fTA4DCB1R56e
        jMz100Z1Dk6ghP3VObFTB87w/UM0cliBfhyLMK3cnUsFda5lpl2svN4lttWVhdL+fK2nx8NIrEhRw
        i87Ll/KQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUrY-004wHa-O1; Sat, 14 Jan 2023 00:57:36 +0000
Date:   Fri, 13 Jan 2023 16:57:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 05/24] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <Y8H+AC+S95eFy/Bs@bombadil.infradead.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
 <20230114003409.1168311-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114003409.1168311-6-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:33:50PM -0800, Luis Chamberlain wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static bool super_should_freeze(struct super_block *sb)
> +{
> +	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
> +		return false;

This is used.

> +	/*
> +	 * We don't freeze virtual filesystems, we skip those filesystems with
> +	 * no backing device.
> +	 */
> +	if (sb->s_bdi == &noop_backing_dev_info)
> +		return false;

I however had dropped this and forgot to update my branch.

> +
> +	return true;
> +}


So the call to super_should_freeze() is removed and the check for the
flag is open coded.

  Luis
