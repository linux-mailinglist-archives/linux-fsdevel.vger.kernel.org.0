Return-Path: <linux-fsdevel+bounces-31347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F11995138
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 16:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEA41C24BF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E101DFD8E;
	Tue,  8 Oct 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="W/H8XNDF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033D1DF978
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396872; cv=none; b=TImq+XGSk9c8rXAmXlARCUWbagYi2/Pa3FYxEPpvrIIKz07srOZykBSHBBy17TSEFGHNQr0BtUjXl8YwrgnofjliBMjQRwiMbv777/d+4zOkHE/0QOP8UWknedEeBsFfz/UMsFiA7U2CeXxxPNhAINpfxYvQsxxmYez9Pis/YBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396872; c=relaxed/simple;
	bh=5aoQfcWfquO8q33TtZ1UTCdHm8yAW/7J4xonT60sqmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPRtFc3JveV7gd4QR1QLZGY/atvPseIYzuM8KUThVurDkKzq2VDb77IHNRJ7ylcxiU3hvpHoWkdgPR3+YlTt96GnZl5Bhg+i8XHoxHjcPQcRp10dXXz11DExR5/3WBsxjmJIKWrdPga+uYIpUAd2cBygIneVM05USbw0EBoMPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=W/H8XNDF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9932aa108cso530298866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728396868; x=1729001668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBVGFNELeNzrNE/pUTBOb0mu55heBoVv/TX9AMKEIYw=;
        b=W/H8XNDFivUW9VLnSktT+XzOQXUH3KE0rFITwhcgz4btk/AWlmh/OdsClCUOhNcIXh
         W8zoHvo3Zr5sTMs/BuZFX3HGv/oqz6buC4/Qv9ylna96il+m/MjNkPlPiDrga3DgBJ5U
         bfsQs6p5jHvrLnUnP0XiWOMda6XCWr/LvSiEwRJgEHKXoz3isJgoWzRmBjBVKBQOdhMl
         0t/pD1r+4ic95bt1qmkneU6jZujZV8e0O13lqEnvF7UTLA96A49rX3dvudq2CEaxz35q
         D9JFCI/I4r0CUW8ka1ylAmLpSsHK31R6wOxGcBTUpV76wivYVk3HcfYT8M4VaRv5UnJx
         2Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396868; x=1729001668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBVGFNELeNzrNE/pUTBOb0mu55heBoVv/TX9AMKEIYw=;
        b=jH62eQnXcD0Od/6NV+1+h2EjboaF085S1lMmFYahizD9Ph1J4yf64fX9Vuot0Fn9r8
         w9cD5AF0VbZSrnDWQjN1COdZOcSuCs023jS5weDDYfRjTcChdxNNVrFdeuwXUu9HzLPL
         IhlA14e2MEcR6NNnulRiXKY4aLYKVbr9ScVHSoijGX71dT6y3bVqPL57keoQLGJ3L7MR
         rofW4/lKn79pQ/apOWSNSJZIyc8+xeXPHFnO7ANK6kMaWjzCPAWe2Y3sLNxnHGJ18tma
         I3nd6RIOggT9ObI5di9NDc60ELZGJ0PZ3ygRskUqbqRe7IgVTCcwQXqtsvMoI7E8mbpu
         /7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXf+c9LGd305ZkUcJCi7jBSFaRdGudJYq6sxj44wFvqhkCpe9aL6C0RIkl5VZ41194jBbWl5BBEg41U52V@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmtHgEv9DCiPEqpXq5Fh5L8ORVVsLbI4xlLIlJME0fP+aTUng
	3M/vaciWNGV2vg/Yx0hdPr5LkIxZUig9rMVWF137Z4fpGMaR3nfT4nhhIC2HJsDpbXHYxPCGh1v
	H3Kg1M33G7D0BRq4sAww7xmhhs7YXnB4Am5UAaQ==
X-Google-Smtp-Source: AGHT+IHk7euKn0dAZXT3q629EL9K9j/synWTQJVFme/t1o1SfzpypUdoyToXvWJFg+KpMfYuEfL1GEA/mnXYkTqoe0k=
X-Received: by 2002:a17:907:7fab:b0:a99:4649:af69 with SMTP id
 a640c23a62f3a-a994649b64bmr886505266b.15.1728396867688; Tue, 08 Oct 2024
 07:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com> <20241003130127.45kinxoh77xm5qfb@quack3>
 <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com> <20241007162311.77r5rra2tdhzszek@quack3>
In-Reply-To: <20241007162311.77r5rra2tdhzszek@quack3>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Tue, 8 Oct 2024 22:14:16 +0800
Message-ID: <CACuPKx=-wmNOHbHFEqYEwnw6X7uzaZ+JU7pHqG+FCsAgKjePnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL
To: Jan Kara <jack@suse.cz>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:23=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 06-10-24 20:41:11, Tang Yizhou wrote:
> > On Thu, Oct 3, 2024 at 9:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> > > > From: Tang Yizhou <yizhou.tang@shopee.com>
> > > >
> > > > The name of the BANDWIDTH_INTERVAL macro is misleading, as it is no=
t
> > > > only used in the bandwidth update functions wb_update_bandwidth() a=
nd
> > > > __wb_update_bandwidth(), but also in the dirty limit update functio=
n
> > > > domain_update_dirty_limit().
> > > >
> > > > Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.
> > > >
> > > > This patche doesn't introduce any behavioral changes.
> > > >
> > > > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > >
> > > Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTERVAL =
does
> > > not seem much better to be honest. I actually have hard time coming u=
p with
> > > a more descriptive name so what if we settled on updating the comment=
 only
> > > instead of renaming to something not much better?
> > >
> > >                                                                 Honza
> >
> > Thank you for your review. I agree that UPDATE_INTERVAL is not a good
> > name. How about
> > renaming it to BW_DIRTYLIMIT_INTERVAL?
>
> Maybe WB_STAT_INTERVAL? Because it is interval in which we maintain
> statistics about writeback behavior.
>

I don't think this is a good name, as it suggests a relation to enum
wb_stat_item, but bandwidth and dirty limit are not in wb_stat_item.

Yi

>                                                                 Honza
>
> > > > ---
> > > >  mm/page-writeback.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > index fcd4c1439cb9..a848e7f0719d 100644
> > > > --- a/mm/page-writeback.c
> > > > +++ b/mm/page-writeback.c
> > > > @@ -54,9 +54,9 @@
> > > >  #define DIRTY_POLL_THRESH    (128 >> (PAGE_SHIFT - 10))
> > > >
> > > >  /*
> > > > - * Estimate write bandwidth at 200ms intervals.
> > > > + * Estimate write bandwidth or update dirty limit at 200ms interva=
ls.
> > > >   */
> > > > -#define BANDWIDTH_INTERVAL   max(HZ/5, 1)
> > > > +#define UPDATE_INTERVAL              max(HZ/5, 1)
> > > >
> > > >  #define RATELIMIT_CALC_SHIFT 10
> > > >
> > > > @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struc=
t dirty_throttle_control *dtc,
> > > >       /*
> > > >        * check locklessly first to optimize away locking for the mo=
st time
> > > >        */
> > > > -     if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTE=
RVAL))
> > > > +     if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVA=
L))
> > > >               return;
> > > >
> > > >       spin_lock(&dom->lock);
> > > > -     if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_IN=
TERVAL)) {
> > > > +     if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTER=
VAL)) {
> > > >               update_dirty_limit(dtc);
> > > >               dom->dirty_limit_tstamp =3D now;
> > > >       }
> > > > @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_wri=
teback *wb,
> > > >               wb->dirty_exceeded =3D gdtc->dirty_exceeded ||
> > > >                                    (mdtc && mdtc->dirty_exceeded);
> > > >               if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stam=
p) +
> > > > -                                        BANDWIDTH_INTERVAL))
> > > > +                                        UPDATE_INTERVAL))
> > > >                       __wb_update_bandwidth(gdtc, mdtc, true);
> > > >
> > > >               /* throttle according to the chosen dtc */
> > > > @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mappi=
ng, struct writeback_control *wbc)
> > > >        * writeback bandwidth is updated once in a while.
> > > >        */
> > > >       if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > > -                                BANDWIDTH_INTERVAL))
> > > > +                                UPDATE_INTERVAL))
> > > >               wb_update_bandwidth(wb);
> > > >       return ret;
> > > >  }
> > > > @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct b=
di_writeback *wb)
> > > >       atomic_dec(&wb->writeback_inodes);
> > > >       /*
> > > >        * Make sure estimate of writeback throughput gets updated af=
ter
> > > > -      * writeback completed. We delay the update by BANDWIDTH_INTE=
RVAL
> > > > +      * writeback completed. We delay the update by UPDATE_INTERVA=
L
> > > >        * (which is the interval other bandwidth updates use for bat=
ching) so
> > > >        * that if multiple inodes end writeback at a similar time, t=
hey get
> > > >        * batched into one bandwidth update.
> > > >        */
> > > >       spin_lock_irqsave(&wb->work_lock, flags);
> > > >       if (test_bit(WB_registered, &wb->state))
> > > > -             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_I=
NTERVAL);
> > > > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTE=
RVAL);
> > > >       spin_unlock_irqrestore(&wb->work_lock, flags);
> > > >  }
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

