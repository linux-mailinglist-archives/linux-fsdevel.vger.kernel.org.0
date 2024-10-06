Return-Path: <linux-fsdevel+bounces-31120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBD991E45
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D95AB20ED6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68850176AA3;
	Sun,  6 Oct 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="KzByrRQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736754F95
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218487; cv=none; b=jpGwAmJCEILqL119FuSOe1rkmazNSqRLYHCiiRo8b5VCie6/KzmojVVjrbaxGTrpLeejE7rT8xPXRa4rkWmFgedmqcbo6TkiqDkLrps5iTwOG++i8K5i8QuZTKcaSLIiHdsN94tCQukKFTT2Myr8EAXYJ45RKWJtNNX3xsu7V1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218487; c=relaxed/simple;
	bh=u8Mj+N0uBo+FjlXTOOH0rCGocurIdJqfnIy06CFNZ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQMQbO2KcaYrG1X7j3c9Xt5Gs90Ql0cNEUsR/sn8IFWt7lcYWY0ghsGbHoxbq97gxJwZbAVXA1GxGx3q8BDW/vEIe4sV89OSMyy/om2Syhur+OuXNAvRaC1BwDuFrxt4giiUWhN8gwUTmqYFFx3Axf4Lio/ntZdml8WBJ5pEJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=KzByrRQs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so4947932a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728218483; x=1728823283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfp1qjvTY96JjSBPZFBQdcNzYYrkwI+G1xfIpJuix4g=;
        b=KzByrRQsWL0+ym4Mh0UGvu24GFDG3bG9I5ZtMN0so5vw3XZFZUC3s7dea1fGQDiX+K
         Jj/4OwWTG/cbTgM8PZKG+EM4jsAUR54A6KLx89t5KoIFMKisOmT3A/HxoQXFGgw5iWBV
         n0wk7qdlk3PtMdbzrIBXxyG2pEna+VL10KNLe2SaNeSR5cLulsfMO6iHCMos/B8UXfZs
         FGTS5fncofwn9O+viaDqD6JePcJa+vWGVOFgQ4GILSJo92uNewlKKmY7m15/eoQZ8suT
         tc30WLKXWrzAjcV7jhii7a6JFOW7nXok2+Ju7jFQH9ww6D/ANAtaogsM0XdFo2wWB1iD
         kp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728218483; x=1728823283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wfp1qjvTY96JjSBPZFBQdcNzYYrkwI+G1xfIpJuix4g=;
        b=Qmadl/QcDxGE58hxE9XNykyzQbmWZZ8E5ZQUSSAB/1tsT4350keDLTUVFi6FbHT61r
         65FVg5R5NjpML0ojZmnRfWf9sl+92sF7z8LTJ2ILMvl3IltCyfShkGzHHkfJROR1Ir6l
         /3c2dnb19dqlOSOBs+yTjZmsLos+UXJ1eyAIz1QJzd0vky/mkU0Umvc5/1I6Fdvik+7J
         rf3QkBbepdkj7fI6Q0xRHGfAB+8a3UjrfIJGkDU7sPTy39ABTU18J1fo4FFIWeF6ERoW
         cX7nUSIyOnyWgiLOb0dbtzRC4MPYlR4UaA4xmVpQBu1CYEiqYydW8N+Jh/yYkFVw4SZN
         4Lxw==
X-Forwarded-Encrypted: i=1; AJvYcCVVKq0ypd+yOSgHGvn+Rs/xsD2QLOrIE99DExn8cPL5z0j54xeeDskchxGwWuA7/t3ypl8c7DuM7acCN5SH@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJxY5U7dMkXyywAYinG8zIYNdeXa8grEzom3OqMZ7PS+6LXBz
	/hKDxFx+BFVDTj4Vs2M/VZTMflvaXkrUdJhAsAPAQg+/IGlZYTTQad0be5I8D46JcgeTj3lFH+I
	8fZvwO/CdhDcUvwb8g7rtNwl05jsCfscg0TeY8g==
X-Google-Smtp-Source: AGHT+IEF9NwbobBLuKG517PdIWkR4xGN0N5GZnoenM1ha2mMz3y+73DuJ+bYd39ST4E88BP40fitG4CKTsuEf/ce1/U=
X-Received: by 2002:a05:6402:4314:b0:5c7:1f13:9352 with SMTP id
 4fb4d7f45d1cf-5c8d2ed3439mr7944293a12.34.1728218483427; Sun, 06 Oct 2024
 05:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com> <20241003130127.45kinxoh77xm5qfb@quack3>
In-Reply-To: <20241003130127.45kinxoh77xm5qfb@quack3>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Sun, 6 Oct 2024 20:41:11 +0800
Message-ID: <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL
To: Jan Kara <jack@suse.cz>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
> > only used in the bandwidth update functions wb_update_bandwidth() and
> > __wb_update_bandwidth(), but also in the dirty limit update function
> > domain_update_dirty_limit().
> >
> > Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.
> >
> > This patche doesn't introduce any behavioral changes.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
>
> Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTERVAL does
> not seem much better to be honest. I actually have hard time coming up wi=
th
> a more descriptive name so what if we settled on updating the comment onl=
y
> instead of renaming to something not much better?
>
>                                                                 Honza

Thank you for your review. I agree that UPDATE_INTERVAL is not a good
name. How about
renaming it to BW_DIRTYLIMIT_INTERVAL?

Yi

> > ---
> >  mm/page-writeback.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index fcd4c1439cb9..a848e7f0719d 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -54,9 +54,9 @@
> >  #define DIRTY_POLL_THRESH    (128 >> (PAGE_SHIFT - 10))
> >
> >  /*
> > - * Estimate write bandwidth at 200ms intervals.
> > + * Estimate write bandwidth or update dirty limit at 200ms intervals.
> >   */
> > -#define BANDWIDTH_INTERVAL   max(HZ/5, 1)
> > +#define UPDATE_INTERVAL              max(HZ/5, 1)
> >
> >  #define RATELIMIT_CALC_SHIFT 10
> >
> > @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struct di=
rty_throttle_control *dtc,
> >       /*
> >        * check locklessly first to optimize away locking for the most t=
ime
> >        */
> > -     if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL=
))
> > +     if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL))
> >               return;
> >
> >       spin_lock(&dom->lock);
> > -     if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERV=
AL)) {
> > +     if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL)=
) {
> >               update_dirty_limit(dtc);
> >               dom->dirty_limit_tstamp =3D now;
> >       }
> > @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_writeba=
ck *wb,
> >               wb->dirty_exceeded =3D gdtc->dirty_exceeded ||
> >                                    (mdtc && mdtc->dirty_exceeded);
> >               if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > -                                        BANDWIDTH_INTERVAL))
> > +                                        UPDATE_INTERVAL))
> >                       __wb_update_bandwidth(gdtc, mdtc, true);
> >
> >               /* throttle according to the chosen dtc */
> > @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mapping, =
struct writeback_control *wbc)
> >        * writeback bandwidth is updated once in a while.
> >        */
> >       if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > -                                BANDWIDTH_INTERVAL))
> > +                                UPDATE_INTERVAL))
> >               wb_update_bandwidth(wb);
> >       return ret;
> >  }
> > @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct bdi_w=
riteback *wb)
> >       atomic_dec(&wb->writeback_inodes);
> >       /*
> >        * Make sure estimate of writeback throughput gets updated after
> > -      * writeback completed. We delay the update by BANDWIDTH_INTERVAL
> > +      * writeback completed. We delay the update by UPDATE_INTERVAL
> >        * (which is the interval other bandwidth updates use for batchin=
g) so
> >        * that if multiple inodes end writeback at a similar time, they =
get
> >        * batched into one bandwidth update.
> >        */
> >       spin_lock_irqsave(&wb->work_lock, flags);
> >       if (test_bit(WB_registered, &wb->state))
> > -             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTER=
VAL);
> > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTERVAL=
);
> >       spin_unlock_irqrestore(&wb->work_lock, flags);
> >  }
> >
> > --
> > 2.25.1
> >
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

