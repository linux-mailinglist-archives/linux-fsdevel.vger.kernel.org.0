Return-Path: <linux-fsdevel+bounces-67186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2AC3761C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DBEC4E4DCF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1D2F8BF4;
	Wed,  5 Nov 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kpgzigv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4C246793
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368649; cv=none; b=ifnEdJ8FLnNd9GzX+Y5SEJuTogfaTQTZbKsjmS7Q55r0RgrFFTz/ivkhaFOru8VIqcT3ODjhmC8+9UwMsu8NgHLURGVXR4X6MPkBPAehBm3LQXjUXA2a7KLNokbkRglNpgDt/H//z4tXo0cwpcsP7X2ouhFg0s92ZRFUK+Rou/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368649; c=relaxed/simple;
	bh=AR3Tr51DEIZpKjlHia+yL3++n71VyHBWu/YGG/C5b8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1mkJOhBbTO4uzgmXGUmpvS1vP8Dyhwiji+p4iFxwWej18FbeAn/OX/k8utjTdiND29DEAMjZ1tj4b9FGvs0eoca1WRaoNxLEp41c5wwRGdykxJBJWnD9W07F10SylCP7jXzReF8BydNnbFuCCzfza9oMkzCRH8wCxeTlKKV9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kpgzigv0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426fc536b5dso107863f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762368645; x=1762973445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O71bTvl8ycrFadW+n507Eymg3koTfCjZxvdMhis1QVs=;
        b=Kpgzigv0S1IIys/wQWAoM2CgU4JWlK9M+bqMSllxZtpBUaOk5KuzPcLwKs/v1xUHU1
         /HfqvK+Btn82+Yck3ghcgZRxnrAMWjMeN1lnx5Y2aU89IWdroSzvL0G/HpqIpHkXh7A3
         cMFH2sxBFPyv7/MvtqyPxh4vx20v+Olmky2iI2WTwJlpZWIPLg5qTLMoXJoS1C000a3j
         j9HHg9z+0ri+ZNKUbTU/IMFeAgn6mQZ49SZcjFPEO7d7vceU6N5w+sYERmrAJXEXSZ1v
         8SvTO/LqUSfUg24WXMs/IXL8OBMaxV/vuNi3EHxywO0/+fENsTel9F4LggKjjfDwDAPv
         MDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368645; x=1762973445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O71bTvl8ycrFadW+n507Eymg3koTfCjZxvdMhis1QVs=;
        b=KOKWKLx0nQ8v2/CugpADob9+LWKhhzLcvZQKiUrODffceiKu9E5CtH3EUeXeQUkXZR
         iWFbxXAEZFfRpTUrnKkeLhoKRNi976xG2X/ZvShol8cssDBxVTdjV+oMfn0P/gF4CeuF
         C4/aTRmHOTsSmsAgjYnku3sgiTgpR6s/b2IfBiZfFbkzBAKNNF/jTeteSkLWJgvsZGKW
         owAxDgJwqCo7Dpha81JIQcKJg/itLwEi6cHQO0DV+Eso6YqP4cKxH2UBKebxPZ835Yex
         u5yJTe7V+fAjQvAe5gqwGIj2/j7dqCSJQSZhXX0NGJh/kVrvQNHtOQZyMyS9n+afP1Eb
         P9gw==
X-Forwarded-Encrypted: i=1; AJvYcCVUOSfBIjl6lRGJvsqfjFlKmkB/EMSlUXd0MTJtep/o6ZNnflWIR51LgIYvPtbw7vpy7t/kvAM3WXTs7u85@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyhDnU3VR5A6B+ZEpsyLN//3qKn7Hvm5d1QTl83qW0rS+maSY
	OX/SruP8zCzZQqHWFwMi6BDBnMiV33/3B/OFZPWNZtqvfBwsVs7o9OoB1HsJew6a98hy3zPF+6R
	Tl1zQbichRBZsyfzi4Fo72feRio5VRJjP/umkkrygaw==
X-Gm-Gg: ASbGnctJ0Qj0pYo+QgYxrsgb/bW5jYd7YcqY7I2Y22zQC59qsfKMx0oLkl1tmg30259
	bvfFWG99YOYJT56rDjmze5cQSiNyJaZOHkR0dAZjkgzSOQ5YINV8TkrlXPNkDNc4ShyQYRCdQWq
	uof3UmRBqYGztn+4/NzK44ZF2dgulYDLVRisy5hmHrsPiC4bXxgrX1zuHsu8GtSGSWj4psEQEIV
	aKST+n7WBARo7D/MXZ4DW7UMo1dvXWt+ipTbVH4NeM85dt2L5i62hXxpSh1d0UEYEKQLKrTw0A1
	xB7DNLOPEGxAP+ZU6zLNoQfHYmhCc5rGvR7NOD9O4NAaNaUg2dQ+awtrLQ==
X-Google-Smtp-Source: AGHT+IEl+wf0FPgtypwBcsggq27T8diJ+W4afYGT2ObX692cZJu0dO8J1HpGnirBYZxDCql0kT1HlaQuaW0+Uyzc6f4=
X-Received: by 2002:a05:6000:26c2:b0:429:cc6b:e011 with SMTP id
 ffacd0b85a97d-429e33063b4mr3794933f8f.36.1762368645525; Wed, 05 Nov 2025
 10:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762142636.git.wqu@suse.com> <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
 <aQiXObERFgW3aVcE@infradead.org> <i5ju5ohsvi54bsgfeuoy22tniln2scxwwl77iuluho5ohqn527@ycwgvf4yclwe>
In-Reply-To: <i5ju5ohsvi54bsgfeuoy22tniln2scxwwl77iuluho5ohqn527@ycwgvf4yclwe>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:50:34 +0100
X-Gm-Features: AWmQ_bn9cmWhEGY2XKLOcbegApB5i6cnfvYmKdk0xlLIg2P37-OrpResm_bmKrQ
Message-ID: <CAPjX3FdpED=XmQy_a6Py=rGh_OoGXXGhBCA_mqAFWAdr=c1S5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] fs: do not pass a parameter for sync_inodes_one_sb()
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 09:50, Jan Kara <jack@suse.cz> wrote:
>
> On Mon 03-11-25 03:51:21, Christoph Hellwig wrote:
> > On Mon, Nov 03, 2025 at 02:37:28PM +1030, Qu Wenruo wrote:
> > > The function sync_inodes_one_sb() will always wait for the writeback,
> > > and ignore the optional parameter.
> >
> > Indeed.
>
> Yeah, apparently I've broken non-blocking nature of emergency sync without
> nobody noticing for 13 years. Which probably means the non-blocking logic
> isn't that important ;)...

Or it means it's not being widely tested or used heavily in production
and when it fails it's hard to tell if that was because it is broken
or because the system state was already severely impaired at that
time.

--nX

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

