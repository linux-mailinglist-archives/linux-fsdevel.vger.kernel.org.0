Return-Path: <linux-fsdevel+bounces-8840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89883B935
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 06:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078DB2874B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 05:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29210101E8;
	Thu, 25 Jan 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTKJfjUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E510A05;
	Thu, 25 Jan 2024 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161933; cv=none; b=ulMKOJEMOI5qhV9IMu/Zi8qMQW0H1Tn1w5q+zzVojhbtOwj/qqb4yC2VUIBuq6CTbsUPqiCqhAUe32j/QGPSGUcN/a1GCpB3lraedpDSsGyDpkJSBBmVi7dLrvbHKvvoXERBt4B8GOGjDJ301Z64+d6cvpisfsmC1xqmaClP61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161933; c=relaxed/simple;
	bh=L9+PrjZJpn9UwKu7+vC2RBX0OsN6HLVknq2se8hzYGE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G11PMnCbjqhaeuoMtGCzLXxoS7G9MUGXs19y6cxnGOIXIFiu4FFeSxhBOGPSfx+CCwrENYmjY/mEwx/FO8d3J1QtIu89V8APiLsU/m8ItlucjlXc5SgHudoCmX313yD/w03e+hnZ/3SZISksIFNhKn9zQx3qRr5FoDG/OHQl+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTKJfjUa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so7065623e87.3;
        Wed, 24 Jan 2024 21:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706161930; x=1706766730; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydMGd6/9j4PSdyd+0AZK8IP7eQDwp3zvF7Pyc9L5xdM=;
        b=MTKJfjUacocTlsHCef77KVFHLgIZ8jung4tMJ9rLwrFmOC3zEG8TNF3cFD6hgyWy7J
         KFokx9OjTjeN+xg1HPqmc86z5ED/+6BeCp5TvaU6nhIdkVUMp7doMoaTe7jUx0TSwkVl
         vU8F6f4AxhcS+TzHYYFS4SyCwwS9zAbF7SlM0/i3hCtMFGj59V7rlW0L/VpOD4ABshfm
         oL9OQXr0PE06Xx9HwBb7vPgjGC8dSwu54HzXbxKNujNB87IfrVIeZNVGhsiQPK7anKrp
         8zHRYL18yN/eglfktoHiqmMgiZU6zJZuxCJr2ShC5eFJQPIOBRIqqf6OK5CosIz7l7FF
         Ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706161930; x=1706766730;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydMGd6/9j4PSdyd+0AZK8IP7eQDwp3zvF7Pyc9L5xdM=;
        b=WjkVfuA2axTUo0qAxtdFk06WO4i5ta69CED0FF7Jh6QzQMX5fkwLJjOh83LHnydzll
         c/XZ90kT1MyDWHRyj94VzjSd13HwMOTpYntOyPpHMVikXpxRQw4kGRR1LGxA9vdqKujI
         SZXtfeJjzOe9iVzeHwgv3PPAQKmMs6fqQ4AUH+g1dwom+2NrhxNXgBUUFNVmDD+jEUnG
         Mm2YflaEaAhleJx10DoG8XM/+KjQU2dwcgTu0344hwCJWM9oMv0FiMpZ+kFMbhXq+ozX
         YBawdqHVligXFNoA4VE4f/Nw5JjTLcWVj9eKeddMaME6wdM8+Tp7fU19Bl6YElr4yRjY
         smmg==
X-Gm-Message-State: AOJu0YxO6Q4wcYxYkpysJEk4kbHfRq1StW0gjEz3yfCiPpUp2sQPhdEn
	tUZaEUUrWKyKyeF5zNaAY2zXg7hkAHSqZ8vmdVC65UIi1uuecO//Ig8pfsbZTz2ZNAxyWlqRP5c
	C7XAwwcghq6R7pZS0R70TPZDcKI+ArcyGT00f1w==
X-Google-Smtp-Source: AGHT+IEZmUn14BenDHW0axlwMkUrIHGPBBH0adXcx93AR+bCeIG5qaqHoozmCoRweT/rM/ygtRuQ2L8YJUd/KRx2Q2M=
X-Received: by 2002:ac2:4db5:0:b0:510:cb1:3d09 with SMTP id
 h21-20020ac24db5000000b005100cb13d09mr185258lfe.122.1706161929763; Wed, 24
 Jan 2024 21:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 24 Jan 2024 23:51:58 -0600
Message-ID: <CAH2r5ms9vcsvV=nv78+Tgy25tH_sKghMWtfmVAoDa9HvL=jRXw@mail.gmail.com>
Subject: [LSF/MM TOPIC] QUIC kernel driver and use by kernel FS
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

With the good recent progress on an in-kernel Linux QUIC driver (see
e.g.  https://github.com/lxin/quic.git), it is now possible to test
use of QUIC for SMB3.1.1 mounts (various non-Linux fileservers support
QUIC, including Windows), instead of TCP (or RDMA/smbdirect).

Given the performance advantages (and obvious use cases for encrypted
access to remote files) of QUIC, the timing is good now to update
others on what we have found out so far in our experiments using the
in-kernel QUIC driver for accessing remote files over SMB3.1.1 mounts
and how it may help other fs (or network block devices) that could
benefit from using QUIC instead of TCP.

-- 
Thanks,

Steve

