Return-Path: <linux-fsdevel+bounces-53636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DDAF150B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5AC3BC0A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5B26E149;
	Wed,  2 Jul 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SATrPgp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0B26B77C;
	Wed,  2 Jul 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458158; cv=none; b=REKK8gFRoXFb6OcxKQjZSBb9eEqrVrLOSBfMfc983J0gpXU//CRzPoOAmPXgq7LAVQDyhB2TCcPbnpJ0052PxJTrwIkhOl7+SaOYa+cCgV032hr3EbjpQpfm1m35w/oKU5SqbYSLm3EWWXfn5rR81caxhbZHkyoAPPfAhMBGdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458158; c=relaxed/simple;
	bh=nWlDCMP58hOFWTq0axrXpQHRvPb4QwTJpACpOuwdVsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfQgwDq+LxVMxgSwDtkeuAeqysaQ7BIj5Fv94Wwwrt1CmYHAhQhCJH+FECKk7Fh+YW57vxPjpzFD4cbuT7Cfc7CfA7XbX6nXhzn3eKTCC2RHcgQQiZHnY/Srgf8iyQOkpGfGF6wa3Y+bHemPu9PrgTb9j1DyEFc2YO1csbqjKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SATrPgp0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e1d710d8so79772005ad.1;
        Wed, 02 Jul 2025 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751458155; x=1752062955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs5XLsalwzapO540In/uO9OhozwTRN8n/LOOBhKcKHY=;
        b=SATrPgp0O7SwpyLXo0wc1SRq+5TJ7u1pCdDDniOHYlIsWIInyCaqLt9R40mYkZIQd+
         6oM9XrJpyEvU9UkyEASFn+4SByU4oU4KDDvN5/5BPLmePkMNBcwnIVPJrHUavB7yCoXq
         mObD6ss0k7MIQuYspnxSYhFjD1206bB/+Pfhk4+lDT4QKZNHIsSDWkUdrPKrb65qDauu
         LjZrClzJTQg/L4721YmmTzl4GlU50sgZG0qwqkb1nsK23G498HQHPS7NJledZ2s1/Vmc
         FMputq0+GeWyfAEIAxbCSIuqLnd8WOO8TDMo6v9rtnCglkwbx2EkpVh3rKRpfDrGM5wW
         +qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751458155; x=1752062955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs5XLsalwzapO540In/uO9OhozwTRN8n/LOOBhKcKHY=;
        b=BMzVVSk2YYSSy3OWmrgYUvJJv0NhIMRD4e0BNBx3sRcFWxYEa9YneWh723VCdvqMRI
         wfWoUbxAmZWQIIMXNTteObsA8eGHXXXXVUAfkc14bP3jQcn492gI0a6X+o81vkIzaAna
         +4b48v9xIzGKOScEABKK8SFcLWnZcVNlmhkhrNeGt+LksBL4c56/gq4cyy6PtaMAxiWu
         yYBVTMfXkX8Nhi6ZM15Uq4yvhcw1iEQNKECWFtsVexD0iHg0cQQDQssTs/AXZt5AO5JT
         pyNIuWDFsIFoMPjUfPvcDUoVlFFQ2stEoTayG0G616+hkWDsbwPubPHcLv71PiSFqzHQ
         Pk7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZnjuS98w15grtDPZkTdrF5eWr/LAqWW74axaM9tnBrPDJHurXlyG7P7oGnaLTX2b4WJ1MJkm/Ptdvopv/@vger.kernel.org, AJvYcCVcokLnltiWOCB6yENPVDvxfHzk5YLR3P1pXHR0ecxS1p6+/O2JkB/AYi6SPMqknNikzZS9lE99GqeC@vger.kernel.org, AJvYcCWNRXGSXTY8JTuRruCsNGBermAww3v9YUsX6BCD1IcQPnbPzV+Sq3NX2dNZQnrS+1DzjpSdw+1eoNzIOS3Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KFK3naxOFwk0cINddOTMDDA9oo/SBkDgHFN2PDd3ONC9I09K
	pK8i/q6i3fix8djz4fCci20yGrDjU+Q2saYjFq68KwqTnKVJRoYEOu54OQVsko+N
X-Gm-Gg: ASbGncuX7GdCrLxm9xCRjkvqFI8jvywB4vCdRuRkAoOgnzo8dAKZtFAy0jZANt2PvYh
	IvmdaufZpSbP/cT+6aHTNAg8SQTxxNCeHchGoSUh6fajHHzaJGmJVqsLKa+JCrxCvCMnH9WJrzQ
	S8dg754oaBiebVdgIP6eIq3Dt0ZJdvfG7PHzr/Ay+PP9mtJWmFbL+OfrCgQRJ1Z9T4rRI0b4IrG
	IJ6XTTPvchR/PCuwYayWF0XBl9GfZeKwPZ8/1MeV6RUW2NKzQbxjy6Wv7a+vNXHXOz/gNC8AcXt
	VOARUrir1Q9X7wLuHILOeux1VkLXmDFNZz/Uj1jSGk+E5Dsu0jLgnXSQZfSL1CzGCaKjI/zlX4g
	=
X-Google-Smtp-Source: AGHT+IExaVpuYpi7D3hH/cDxFE+Ue5Om6VAYFyjkLoHEu40YV+B0qu6u+f3KaDzPw7fih6wRctT+mA==
X-Received: by 2002:a17:902:f64f:b0:235:f459:69c7 with SMTP id d9443c01a7336-23c6e5ed89dmr46270605ad.52.1751458154933;
        Wed, 02 Jul 2025 05:09:14 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1b03sm135015125ad.10.2025.07.02.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:09:14 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: djwong@kernel.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with locks
Date: Wed,  2 Jul 2025 20:09:12 +0800
Message-ID: <20250702120912.36380-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701184737.GA9991@frogsfrogsfrogs>
References: <20250701184737.GA9991@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Jul 2025 11:47:37 -0700, djwong@kernel.org wrote:
> On Tue, Jul 03, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > In the buffer write path, iomap_set_range_uptodate() is called every
> > time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> > know that all blocks in this folio are already in the uptodate state, so
> > there is no need to go deep into the critical section of state_lock to
> > execute bitmap_set().
> > 
> > Although state_lock may not have significant lock contention due to
> > folio lock, this patch at least reduces the number of instructions.
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3729391a18f3..fb4519158f3a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> >  	unsigned long flags;
> >  	bool uptodate = true;
> >  
> > +	if (folio_test_uptodate(folio))
> > +		return;
> 
> Looks fine, but how exhaustively have you tested this with heavy IO
> workloads?  I /think/ it's the case that folios always creep towards
> ifs_is_fully_uptodate() == true state and once they've gotten there
> never go back.  But folio state bugs are tricky to detect once they've
> crept in.

I tested fio, ltp and xfstests combined for about 30 hours. The command
used for fio test is:

  fio --name=4k-rw \
    --filename=/data2/testfile \
    --size=1G \
    --bs=4096 \
    --ioengine=libaio \
    --iodepth=32 \
    --rw=randrw \
    --direct=0 \
    --buffered=1 \
    --numjobs=16 \
    --runtime=60 \
    --time_based \
    --group_reporting

ltp and xfstests showed no noticeable errors caused by this patch.

thanks,
Jinliang Zheng. :)

> 
> --D
> 
> > +
> >  	if (ifs) {
> >  		spin_lock_irqsave(&ifs->state_lock, flags);
> >  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> > -- 
> > 2.49.0
> > 
> > 

