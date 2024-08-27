Return-Path: <linux-fsdevel+bounces-27426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE79616F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B874A1C23503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7FF1D2F52;
	Tue, 27 Aug 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG0lNHWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B971D1757
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783165; cv=none; b=mlaznXqsfuRh1i97wLt4QZa1cT+i+8PHgXBX9dn3AmCqtqnG1frImlGEq626o2IiKs56G4vM9QHkobXsdz11hu/qT6KfJWQpx1ZIzJQWr/BtVQ84lC4tf3a5SUbDTnrt3mkYM11+CqbFq9dhnBRq15d+N9xJZ9MK2cDcd+k3oaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783165; c=relaxed/simple;
	bh=nxcMUPkBKykb3i5RJjQJ5czkCAct+wxS2Ut+p+S66Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnVpN4BXmH39mjhnAweEhK32tij1g0Kuf5LXv/u2Ef6XLcTXnrQ6ii9XyNhr4jZbqOQy2+IHKwXrVXS2mffj6JLVDFQRTS66QUOCINCARnKul+Z2BNlMNa9FO6WZ1Ujubkrmmq5KpS0qVvsGbX8AIwjj4GWv+rl/73txBItIEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eG0lNHWj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3719398eafcso3395383f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724783161; x=1725387961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taToXkOoFI4dvSDRErd9uMqfnQgFfJ+8kZ6b29LeX7w=;
        b=eG0lNHWj6O0ShOFvp61MEY1/u6bUy/AH4hMo6vOnc7qF/9vu/o5g7Ts9xKes68u3OU
         c1VhWq3GnImef/X0dTpY6eNRDxf6ZT2OESI0hJU9sLMCCODydgJE7Kk1YWUn9QSoXg93
         drzeI35YncCdJmQgpyqbfK0L0u5VtZmaP1l/aAlavpDi9mZfs5CPAyIxjOP645djen2A
         s7n6Fz+ns/WYqxRAr+8H7PzIGOnndmUpDimWrYVEYrkS/9Ob9/y8nvY9HpaYZhsWocEq
         DtlCINkLrJ9pBqYa++3eosorS63CfVikfjYM6xHjQ2oB1KROTknLPs6XxjQtQojBB8gS
         rOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724783161; x=1725387961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taToXkOoFI4dvSDRErd9uMqfnQgFfJ+8kZ6b29LeX7w=;
        b=VuXe2dkbfMJEueNZSYxmSUQBBASSUm5MF6LoGDETKLNL78ym0GHjno5Bj/dwo0AW8x
         qlv6vG/POEyreuQCd1ZWU7dX6zaLR69RKCE3wtZntqYGsOz/kbGEWRzjDA6KeLAvW5WG
         BIYaRkqWg28PzCNTvjzYIUnjYRnbAnyBX8AKo3V2ueOgUGrvmEaVSDweTErA/25uh9Eb
         uvBPvzqlAdb3ulfIpzZQJL9DPZYbfDb3ODzi0Q7m0+nj+NVEZicpSzgHm9cc7Wb21z5R
         Fujd0vx6ss3qL80Bfkb4WhP+C1L5eAH8uM/prwFv3cmvb9GG9xEhP9cf/XhUKvAbP2VJ
         u4qg==
X-Forwarded-Encrypted: i=1; AJvYcCVF/yy0wEcBiTpuQQ9Al1/pDccTI3tKxvlBE7o3jpSK+uu8N0kRd0mCI42bLKA4lIOszWoCkGp3wovpDI9I@vger.kernel.org
X-Gm-Message-State: AOJu0YzqI48AT0IjnFJ1RF/Aqgyd6sLvL2kjyf2D6HCLEHif/I2hjfLd
	xZ1VNQ5lDnMYJBoXtfh44lIaztJDTRtJrkoY2j+Q1JQaDQmU7xFvoALoeH4t6pw=
X-Google-Smtp-Source: AGHT+IFQ8lUlRu+aDZKavRPPMRony6coPOxIyBtzcUISjTEWst8RDFfV+iVgU1oEURVQjv6ZAhuIGA==
X-Received: by 2002:a05:6000:8:b0:371:7d84:9bef with SMTP id ffacd0b85a97d-3731187d118mr10030791f8f.28.1724783160648;
        Tue, 27 Aug 2024 11:26:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm13842509f8f.8.2024.08.27.11.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:26:00 -0700 (PDT)
Date: Tue, 27 Aug 2024 21:25:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.11, v2
Message-ID: <da03e2a7-0293-4b28-9a08-6c0fad51b9a3@stanley.mountain>
References: <73rweeabpoypzqwyxa7hld7tnkskkaotuo3jjfxnpgn6gg47ly@admkywnz4fsp>
 <d0da8ba5-e73e-454a-bbd7-a4e11886ea8b@stanley.mountain>
 <ltl35vocjtma5an2yo7digcdpcsvf6clrvcd4vdkf67gwabogf@syqzgnw5rodw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ltl35vocjtma5an2yo7digcdpcsvf6clrvcd4vdkf67gwabogf@syqzgnw5rodw>

On Tue, Aug 27, 2024 at 12:23:22PM -0400, Kent Overstreet wrote:
> On Tue, Aug 27, 2024 at 01:53:55PM GMT, Dan Carpenter wrote:
> > On Thu, Jul 19, 2024 at 06:36:50PM -0400, Kent Overstreet wrote:
> > >       bcachefs: Unlock trans when waiting for user input in fsck
> > 
> > Hello Kent Overstreet,
> > 
> > ommit 889fb3dc5d6f ("bcachefs: Unlock trans when waiting for user
> > input in fsck") from May 29, 2024 (linux-next), leads to the
> > following (UNPUBLISHED) Smatch static checker warning:
> > 
> > fs/bcachefs/error.c:129 bch2_fsck_ask_yn() error: double unlocked 'trans' (orig line 113)
> > 
> > fs/bcachefs/error.c
> >    102  static enum ask_yn bch2_fsck_ask_yn(struct bch_fs *c, struct btree_trans *trans)
> >    103  {
> >    104          struct stdio_redirect *stdio = c->stdio;
> >    105  
> >    106          if (c->stdio_filter && c->stdio_filter != current)
> >    107                  stdio = NULL;
> >    108  
> >    109          if (!stdio)
> >    110                  return YN_NO;
> >    111  
> >    112          if (trans)
> >    113                  bch2_trans_unlock(trans);
> >                         ^^^^^^^^^^^^^^^^^^^^^^^^^
> > Unlock
> > 
> >    114  
> >    115          unsigned long unlock_long_at = trans ? jiffies + HZ * 2 : 0;
> >    116          darray_char line = {};
> >    117          int ret;
> >    118  
> >    119          do {
> >    120                  unsigned long t;
> >    121                  bch2_print(c, " (y,n, or Y,N for all errors of this type) ");
> >    122  rewait:
> >    123                  t = unlock_long_at
> >    124                          ? max_t(long, unlock_long_at - jiffies, 0)
> >    125                          : MAX_SCHEDULE_TIMEOUT;
> >    126  
> >    127                  int r = bch2_stdio_redirect_readline_timeout(stdio, &line, t);
> >    128                  if (r == -ETIME) {
> >    129                          bch2_trans_unlock_long(trans);
> >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Double unlock
> 
> Those are different types of unlocks.
> 

What tripped the static checker up is that bch2_trans_unlock_long() calls
bch2_trans_unlock().

fs/bcachefs/btree_locking.c
   815  void bch2_trans_unlock_long(struct btree_trans *trans)
   816  {
   817          bch2_trans_unlock(trans);
   818          bch2_trans_srcu_unlock(trans);
   819  }

But looking at it now, I guess if we call bch2_trans_unlock() twice the second
unlock is a no-op.  Thanks!

regards,
dan carpenter


