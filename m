Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1C563EB7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 07:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiGBF7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBF7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 01:59:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8122181E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 22:59:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so582664pfb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Jul 2022 22:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uZ0xpOFi19oX2NSsd7/3TN5SKlTWmXFBnbfZWWRN3+o=;
        b=Eu9CyMWbZ5r0wWq/2vWTdeuHvjbq3lzLM8qxdfhYgWOlhTU3MWYNiq/nGjZEwwyBqj
         kt5fJLzpcRS9wANXNgnufo+3+D9iPaKhZDdh6g9SctqqdRGgeM3ToZvsZzY1vIHP2siD
         hrfkXnBpdFTsvmN54NqOpVB/gbVypEYkTCLHrMnyL7qQq57xSbavAvJPXK5ALm/BUdmi
         WuM+iDyHOGhXuJWR8gKfBmeOTjfJSrrMimjdLG68m+YjQrxw78bbSUO0T6vEtZVjhzPA
         0TicxE3MVeJG/jrq0LrViJKPCE8QGNMab5y2b+CFME+lBd0JFnDsv61myJust/1BQU47
         AjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZ0xpOFi19oX2NSsd7/3TN5SKlTWmXFBnbfZWWRN3+o=;
        b=JhyCWZ849reeM39lz8Z/MShwUgkA3VlmGRbwri1E+TJWinBAqpCGefcir15aZ4PfCA
         0QLpVCiSDXy9TQPLIpfhXzq4AmtRhc53fR34xFibFJoHkk/AlT7mx6M2nw+B4RSmRlbH
         8biIcT45FaY+SXmnrKAU0+4FCA9r6lNqb3YflvQbneET8RR80azSWN+CVw0bZJXNMvAT
         855RNFtR/tEJnh+/1blOHP//FqrcRsornHDnqvU+rDnCVtAAAwOGTckU1rYOFc17FAgJ
         Ba6YiYhEE8qkmUMTTvE0e1UsG16OtNZnFSRzwc0F83RXH48RPkLZISngq32SbGILBw/F
         Cd+w==
X-Gm-Message-State: AJIora/MYHWYcur75N8z4KUnPbWUfnZBre/Ei5Vfj9BD1d9Uw+o0gVEC
        /1Fox35dYpT2thk2KGTmsCXt8g==
X-Google-Smtp-Source: AGRyM1spqZVUMiNenqn9cV3q+dhQ3e3Wwj4F9jDGqOmaq/Sk154X2lfHcqo1SDMuZaB0s1dyC5Y4Mg==
X-Received: by 2002:a05:6a00:451c:b0:525:b802:bc3d with SMTP id cw28-20020a056a00451c00b00525b802bc3dmr24626944pfb.43.1656741555709;
        Fri, 01 Jul 2022 22:59:15 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:4b84:6be1:8a0a:44c9])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090a49cc00b001ec9f9fe028sm5147656pjm.46.2022.07.01.22.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 22:59:15 -0700 (PDT)
Date:   Sat, 2 Jul 2022 15:59:04 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] fanotify: refine the validation checks on non-dir inode
 mask
Message-ID: <Yr/eqIWhz7Z1XpJW@google.com>
References: <20220627174719.2838175-1-amir73il@gmail.com>
 <20220628092725.mfwvdu4sk72jov5x@quack3>
 <CAOQ4uxj4EFTrMHfVY=wFt9aAJakNVQA6_Vq-y-b7yvB0tEDsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj4EFTrMHfVY=wFt9aAJakNVQA6_Vq-y-b7yvB0tEDsiQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:22:28PM +0300, Amir Goldstein wrote:
> On Tue, Jun 28, 2022 at 12:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 27-06-22 20:47:19, Amir Goldstein wrote:
> > > Commit ceaf69f8eadc ("fanotify: do not allow setting dirent events in
> > > mask of non-dir") added restrictions about setting dirent events in the
> > > mask of a non-dir inode mark, which does not make any sense.
> > >
> > > For backward compatibility, these restictions were added only to new
> > > (v5.17+) APIs.
> > >
> > > It also does not make any sense to set the flags FAN_EVENT_ON_CHILD or
> > > FAN_ONDIR in the mask of a non-dir inode.  Add these flags to the
> > > dir-only restriction of the new APIs as well.
> > >
> > > Move the check of the dir-only flags for new APIs into the helper
> > > fanotify_events_supported(), which is only called for FAN_MARK_ADD,
> > > because there is no need to error on an attempt to remove the dir-only
> > > flags from non-dir inode.
> > >
> > > Fixes: ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> > > Link: https://lore.kernel.org/linux-fsdevel/20220627113224.kr2725conevh53u4@quack3.lan/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks! I've taken the patch to my tree.
> >
> >                                                                 Honza
> >
> > > [1] https://github.com/amir73il/ltp/commits/fan_enotdir
> > > [2] https://github.com/amir73il/man-pages/commits/fanotify_target_fid
> 
> Mathew and Jan,
> 
> Please let me know if I can keep your RVB on the man page patch for
> FAN_REPORT_TARGET_FID linked above.
> 
> The only change is an update to the ENOTDIR section which ends up like this:
> 
>        ENOTDIR
>               flags contains FAN_MARK_ONLYDIR, and dirfd and pathname
> do not specify a directory.
> 
>        ENOTDIR
>               mask contains FAN_RENAME, and dirfd and pathname do not
> specify a directory.
> 
>        ENOTDIR
>               flags  contains FAN_MARK_IGNORE, or the fanotify group
> was initialized with
>               flag FAN_REPORT_TARGET_FID, and mask contains directory
> entry modification
>               events (e.g., FAN_CREATE, FAN_DELETE), or directory event flags
>               (e.g., FAN_ONDIR, FAN_EVENT_ON_CHILD),
>               and dirfd and pathname do not specify a directory.

Sorry for the delay. This looks fine to me.

/M
