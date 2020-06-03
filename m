Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E471ED4A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCRBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCRBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:01:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E06C08C5C0;
        Wed,  3 Jun 2020 10:01:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a25so3680186ljp.3;
        Wed, 03 Jun 2020 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2iLycb4I4u+ClXUUA0CCDPb6E6bGBrDChBPF7DQKh5s=;
        b=aTM3zxQdEXzyvTbG2wnsmyG5Ljh4kC5rX2FcLRM6yHZ9CsgexrRB/bG1xtfJfa65A9
         tsuDK3j0xyJTbGyH04PSRBc940UT0MSX3j3Xe+ctCJQMgKojjCOxd1XLmqH5ScZEks84
         m4YCGcEeD9yUDlJ47GdTrkDrj2a8lmTVqNf9eP4QeJb6pOjR64QQILWyFFVmk3gNQgik
         qCJJ0inXRDzPrrokm1ZjCjdg/Ve/bUmhUKBdeHV60tsuFclZjzehk+uWop6vHPnRhhLT
         hpu4HnylpXg3otqK3GBX0ovRt295MjpmsFRrfrwoX3e67peU3xc+oCRxmQ83jwZ1y6EB
         4Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iLycb4I4u+ClXUUA0CCDPb6E6bGBrDChBPF7DQKh5s=;
        b=mA0SNDny3lSdU5ZshxMmdcKkI7XRczGS87YqrgZHa8CbQJd5AI3l20UO1URCN6DX+n
         3lHoGoEDT6bUusbF72AsiDww9LcE9xkeDX0AZlrWrJBNdaujiknZRuUGPAIKVhFqsIel
         mvSWD337IaL2uDqyPvlFnYFIKLMJmOp0b8VDxVc6QnHtwwdrFIFAUUHfSmIn+ZnSpS/A
         ofkyWOhq+f2xiBpJ/LwYHBNGE2/m4kkpBq5savpNiM6irp3xbRCMFjxmObwV3EJxrKxg
         69nDbZjEpfkZ/Ph+RwCZ8yx12DLrTy+Vj29ujmXtxA7BSgcZ7gjLsICx38r41y2axcai
         JRyQ==
X-Gm-Message-State: AOAM532D29PgTYaRQMv8BYcWVDd2evlAyUawt29V7eTBNukn9RJxB1kf
        JEgcPLPMFHDoVAyDgy+5B7g=
X-Google-Smtp-Source: ABdhPJz9gyMboago8Er/iKySN0pf2TCLhXajvZU/DCrvcaHiJNcLnfsThNWvM3P5mHq0O1RvGu2jcg==
X-Received: by 2002:a2e:9816:: with SMTP id a22mr87688ljj.129.1591203697862;
        Wed, 03 Jun 2020 10:01:37 -0700 (PDT)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id b15sm784577lfa.74.2020.06.03.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:01:36 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id F2B391A0089; Wed,  3 Jun 2020 20:01:35 +0300 (MSK)
Date:   Wed, 3 Jun 2020 20:01:35 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200603170135.GD568636@grain>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603162328.854164-2-areber@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
...
>  
>  /*
> - * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
> - * symlinks may be used to bypass permissions on ancestor directories in the
> - * path to the file in question.
> + * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
> + * to concerns about how the symlinks may be used to bypass permissions on
> + * ancestor directories in the path to the file in question.
>   */
>  static const char *
>  proc_map_files_get_link(struct dentry *dentry,
>  			struct inode *inode,
>  		        struct delayed_call *done)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!(capable(CAP_SYS_ADMIN) || capable(CAP_CHECKPOINT_RESTORE)))
>  		return ERR_PTR(-EPERM);

You know, I'm still not sure if we need this capable() check at all since
we have proc_fd_access_allowed() called but anyway can we please make this
if() condition more explicit

	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
		return ERR_PTR(-EPERM);

though I won't insist. And I'll reread the series a bit later once I've
some spare time to.
