Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76F7AF8CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjI0Dqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 23:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjI0Doj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:44:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4F93FD
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 18:09:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69101d33315so8241043b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695776962; x=1696381762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw4CxLGzjxCr48y5eivoSw8LK175CYAL2oeFqsOXGuY=;
        b=sprRkkK19UEhJ4cbX57eeyuwjUDYIJ8AilHF+W27JfhDwllgXy2LEDpr1mlovbCpYf
         qMgOwkxI5K9dMHV173ZsJaSBg2YVMOBWTD/p/tR/JR0xjN4ZryALAK4wTSq/WccI8ef3
         tV4som2J6avxMSprl4aSs+i9jsJdLh7tQS/lSs2IUQWxlgzfsnJBk6qTPZjKM2enF7Ox
         ZLJJGj9cqFrxaZAiMG3X0W1PgtSjWDLMtTyHXYho8NSp2dnOUY+sitHKmls/AlJx+Nex
         Tsj80k68Ul/iEcwvKREuPn7UThmKRWq2NYl22KGQXBIMPCf1YcUUru6oVr/7pZOUha1t
         atIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695776962; x=1696381762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw4CxLGzjxCr48y5eivoSw8LK175CYAL2oeFqsOXGuY=;
        b=vwNT2o4La1sLQOZ5NCnkP9Iuw0a/NI4PYwzDiisz7Ld8DLC2y2Wy2MVN7CSmt5z8PJ
         U99oHifjMZXP1lZeAmeoIIM561cBNEB+G+9/A4px4T/o10NhHHTVQMqCNULWEGfmMD5o
         aJmOU6Fb5hoKyoJ8WlBmJPFMtvCGbjC1i3L4rbw3up5/IxCgWuA3KWTGIC5R0gYBNiEY
         W1Ghu1gAF/XFdv0q3pIJsqQ7z+wxKqfMElKgA2zfgzUL+jnaQhI5WpbWHiB33+0l7amK
         p3QuVgyYHS65ai/TeLD1LvEsSK6Cm9xdD3jS9M8h2wFDYs2nG2dr4NfeKX4Fuxi1JcYm
         /xow==
X-Gm-Message-State: AOJu0YwfJlCVD99HIjjtidVDhHmNSEJnSaLmONIgoUfuae6B83on+oni
        7l/xTwj/UO0W3yLaAFUJezYYew==
X-Google-Smtp-Source: AGHT+IFjzLAZErhj6aNRrOCOr0H+JPBoEkdVkrJMs6di7mDeUgXTRxM6Wv+Lhh82W2upUAwOqIoahQ==
X-Received: by 2002:a05:6a00:2d16:b0:690:4362:7011 with SMTP id fa22-20020a056a002d1600b0069043627011mr790618pfb.24.1695776962386;
        Tue, 26 Sep 2023 18:09:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm10551350pff.1.2023.09.26.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 18:09:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qlJ3H-0064GN-0q;
        Wed, 27 Sep 2023 11:09:19 +1000
Date:   Wed, 27 Sep 2023 11:09:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     cem@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/3] tmpfs: Add project quota interface support for
 get/set attr
Message-ID: <ZROAvzJ/XahcQE14@dread.disaster.area>
References: <20230925130028.1244740-1-cem@kernel.org>
 <20230925130028.1244740-4-cem@kernel.org>
 <E5CA9BA7-513A-4D63-B183-B137B727D026@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5CA9BA7-513A-4D63-B183-B137B727D026@dilger.ca>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:28:06PM -0600, Andreas Dilger wrote:
> I've added Dave to the CC list, since he has a deep understanding
> of the projid code since it originated from XFS.
> 
> On Sep 25, 2023, at 7:00 AM, cem@kernel.org wrote:
> > 
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > Not project quota support is in place, enable users to use it.
> 
> There is a peculiar behavior of project quotas, that rename across
> directories with different project IDs and PROJINHERIT set should
> cause the project ID to be updated (similar to BSD setgid).
>
> For renaming regular files and other non-directories, it is OK to
> change the projid and update the quota for the old and new IDs
> to avoid copying all of the data needlessly.  For directories this
> (unfortunately) means that the kernel should return -EXDEV if the
> project IDs don't match, and then "mv" will create a new target
> directory and resume moving the files (which are thankfully still
> done with a rename() call if possible).
> 
> The reason for this is that just renaming the directory does not
> atomically update the projid on all of the (possibly millions of)
> sub-files/sub-dirs, which is required for PROJINHERIT directories.

Yup, PROJINHERIT implies that project quotas are being used to
implement directory tree quotas, hence everything in the destination
directory should have the same projid as the parent.  This code in
xfs_rename() implements that restriction:

        /*
         * If we are using project inheritance, we only allow renames
         * into our tree when the project IDs are the same; else the
         * tree quota mechanism would be circumvented.
         */
        if (unlikely((target_dp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
                     target_dp->i_projid != src_ip->i_projid)) {
                error = -EXDEV;
                goto out_trans_cancel;
        }

> Another option for tmpfs to maintain this PROJINHERIT behavior would
> be to rename the directory and then spawn a background kernel thread
> to change the projids on the whole tree.  Since tmpfs is an in-memory
> filesystem there will be a "limited" number of files and subdirs
> to update, and you don't need to worry about error handling if the
> system crashes before the projid updates are done.

Except that can get EDQUOT half way through and now there's nothing
to report the ENOSPC error to, nor any way that the application can
interrupt and/or recover the situation. I think that's a
non-starter.

And, quite frankly, it's also massive feature creep as well as
premature optimisation. We don't need tmpfs project quotas to be
"smart" like this; we just need the initial support patch set to -do
the right thing-.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
