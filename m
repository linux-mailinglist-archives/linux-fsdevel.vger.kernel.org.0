Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7F6B3708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCJHBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCJHBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:01:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B35F9ECD;
        Thu,  9 Mar 2023 23:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0N+SCtcY/k9CimqgVMe/YX4md4YEbNQzEDvTCcqt4bw=; b=TbHcAKwtP7qVQnyr4M3BCyYIa9
        /0zMoVu1Ym18t94ZPKH+tFOvb05xiFTdpVwC6jwn/i8aWIfnathj3m2nd+Fz/WuY6K+sj1gnbIrJw
        PLDE5rtBFWDjO8xqpWgtSV+v7c/cZooSVNk+OWZnYWUfuOpDR7H3LV29R6TOwEN1+8fpgTxENcRrN
        Vk5E2dz3TZTGLbzB/xxNiLvMzRNND6Xb1fYjLRDR9K5vOZvqInK/MTtgg8RzRwvLq61MMSRU8Kksp
        qm2jVnkmnbSN62TJt7mvrf5Uw2cddBqIVlrEL4EqgGEdcmBpFlQAduFI+Hsk2g1cx0r2tLMgsSepe
        DNHJzz+A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paWkT-00DKkw-B4; Fri, 10 Mar 2023 07:01:05 +0000
Date:   Thu, 9 Mar 2023 23:01:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        tytso@mit.edu, guoren@kernel.org, j.granados@samsung.com,
        zhangpeng362@huawei.com, tangmeng@uniontech.com,
        willy@infradead.org, nixiaoming@huawei.com, sujiaxun@uniontech.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] proc_sysctl: deprecate register_sysctl_paths()
Message-ID: <ZArVscnCxYfZXwLR@bombadil.infradead.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-12-mcgrof@kernel.org>
 <ZAqvQ57PmdDoNo+F@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAqvQ57PmdDoNo+F@sol.localdomain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:17:07PM -0800, Eric Biggers wrote:
> On Thu, Mar 02, 2023 at 12:28:26PM -0800, Luis Chamberlain wrote:
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index 780690dc08cd..e8459fc56b50 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -221,13 +221,8 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
> >  struct ctl_table_header *__register_sysctl_table(
> >  	struct ctl_table_set *set,
> >  	const char *path, struct ctl_table *table);
> > -struct ctl_table_header *__register_sysctl_paths(
> > -	struct ctl_table_set *set,
> > -	const struct ctl_path *path, struct ctl_table *table);
> >  struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
> >  struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
> > -struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
> > -						struct ctl_table *table);
> >  
> >  void unregister_sysctl_table(struct ctl_table_header * table);
> >  
> > @@ -277,12 +272,6 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
> >  	return NULL;
> >  }
> >  
> > -static inline struct ctl_table_header *register_sysctl_paths(
> > -			const struct ctl_path *path, struct ctl_table *table)
> > -{
> > -	return NULL;
> > -}
> > -
> 
> Seems that this patch should be titled "remove register_sysctl_paths()", not
> "deprecate register_sysctl_paths()"?

Good call! Will adjust.

  Luis
