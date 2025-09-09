Return-Path: <linux-fsdevel+bounces-60647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB2B4A8E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F5361FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384AA3090DE;
	Tue,  9 Sep 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMI2IO4Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A282D2390;
	Tue,  9 Sep 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411597; cv=none; b=RvCv9b2kWtQpOjPNxhQ/aLwF2kMzx/xeFeF7gLJltpENRtP0NweO0VF7EoqPTR2Joj5DEtvY2MLc9SpsoAQU/h64BnFxcrexC/2T+y4fxnGuJDZyExNbeWTVG5SJQXSVRl6sppx2mK2dZN5+ZuoWNSu276gQNihiNSQrbpiYr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411597; c=relaxed/simple;
	bh=fMLxq6TiucmvR7bYhmILcv7h/Uv9JsbdS4EC9Fmg0gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3F+nX+bRde6LAaQsGnGf15su+z9PHT6HJl0vBvKnryKcozSvY9rQ2cH7BiRuoVktIr6gFGA09DEDWHfgFQHnltXweRPqb8Ek5rTLETWOV5TkcIUo8fwQCq3AYlhMYFNi0c1DnDUAsFbaxYWFGDw3+gmYK0PtxtII/APnt/mfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMI2IO4Q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0411b83aafso887426566b.1;
        Tue, 09 Sep 2025 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757411593; x=1758016393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMLxq6TiucmvR7bYhmILcv7h/Uv9JsbdS4EC9Fmg0gY=;
        b=aMI2IO4QcJjx5yGruhF776WZiwyiNpGAMRsNSP2WODQBoT4Uhcmf9ThBU+LYRDjCuN
         k8BShgPkEo58FTJgGFWsX5rWAw+SXOxiW/6s1Gjzb6O6hXYWPOLTfJ3N5yXFDWooiNfz
         BldPg1An+YlnYrASvi1RvR0kvRiwwJRAMHvdOi2Ha88i7WiorDOylLO29jq7zVGcgrqd
         x7IdpXBRoArB5rlZdqcPnOfqxe9iriD5MVsP9jz3k8XRsASdriWX/DmCVz0pwBH8Ey5q
         1C3AHExEZD/xMrklePpSM/crtMX6wf/VnarqtwZNhrZ/0WsQyhWryJW583ug2fUczrFX
         BE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411593; x=1758016393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMLxq6TiucmvR7bYhmILcv7h/Uv9JsbdS4EC9Fmg0gY=;
        b=JW85uhyeAaAZoChH/SlZnQUwyJPjtMco2C9vOz+qjosYZErxeZMXsM8N51h3mNZ+5I
         //hc5b///60UMkgnNaN4D+6Y6KKIZYgGX19uGCvPHAsDcs4gYTDtGoj4+Gji4XkFXA6J
         FPcNGYf+oDUCz0hxvQTtzP2Wy7zCtzvnxAVu8LOQ/7F2/bdQOqxHMGY29WkAY8f0q1jW
         u5oCv1UmGSdtN6T5RGY+epnmbpxR1GUhpuOF99FoK6kMzZWscHZDhduBhVEotS6eYbQf
         SJUrUolL/EaC1reOcJlXBgIuiOKGeuFJC0ZwfX0QwE7m+P7MJdhxA/TIg5scZUs708sG
         Q1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQZtMCW2QkAVX+zYCCkLZ4UNnN5g2xIxelfsNAmMEWDKX6Box85wye/QBV0NRiSVQURE/ku7DbDf+cNLGe@vger.kernel.org, AJvYcCX1TF7VmmLhJ6wBUew9H4eLl0ehLgNO66xDqCJxsfm/OW5E/jaNOzYM0KlPNeJfIClI8OXL8m0EzXM/BAbs@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRDsda1CmPFY+ESJpB88ZcFxQRLwxh38VpzZbJLqoUTrvNyje
	wNT/oXz/pZSJHshAePaPV+HW1i9B2R97FNNXWO8XvA1DmXOa2KAM1bY4Ee1ljRDz4O6eBgQx2BO
	kwg//xTS4y/+T9D936Jm+so8o3EkN8MY=
X-Gm-Gg: ASbGncvJ0KnBr3938lG5sVo8xtVXu0mpkxGS2PNL8YZ4m5K962dr9ackDYPqeV93xlM
	fdfs9cDlpkhBUmLEdsSD0Z6QbNoKsbmVjH52dqgxAHLAoZw5WhCOghDIvC1Tp7lqK6Ei98y0Yxy
	vbIZTXtPWoh6MUug1EQ2cMtlIjX8ceAdWPEH5DPboVck2LQudjQ0vvQjHuVnqkI4h7Y1IZBnamQ
	4/O5hrU8qKRyFixQg==
X-Google-Smtp-Source: AGHT+IE5lbqVo6j80scniqpSUIcsKgunf5VRTh8IsKCrX6AXDUK5P5Dj58UVpkT6jLLAC0fHmgDiA+ax2oWOoXko3OE=
X-Received: by 2002:a17:907:3e20:b0:b04:8955:ec71 with SMTP id
 a640c23a62f3a-b04b14abdd1mr1040581066b.23.1757411592835; Tue, 09 Sep 2025
 02:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <766vdz3ecpm7hv4sp5r3uu4ezggm532ng7fdklb2nrupz6minz@qcws3ufabnjp>
 <20250904154245.644875-1-mjguzik@gmail.com> <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
 <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
 <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com> <rvavp2omizs6e3qf6xpjpycf6norhfhnkrle4fq4632atgar5v@dghmwbctf2mm>
 <f9014fdb-95c8-4faa-8c42-c1ceea49cbd9@linux.alibaba.com> <fureginotssirocugn3aznor4vhbpadhwy7fhaxzeullhrzp7y@bg5gzdv6mrif>
 <CAGudoHGui53Ryz1zunmd=G=Rr9cZOsWPFW7+GGBmxN4U_BNE4A@mail.gmail.com> <tmovxjz7ouxzj5r2evjjpiujqeod3e22dtlriqqlgqwy4rnoxd@eppnh4jf72dq>
In-Reply-To: <tmovxjz7ouxzj5r2evjjpiujqeod3e22dtlriqqlgqwy4rnoxd@eppnh4jf72dq>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 9 Sep 2025 11:52:59 +0200
X-Gm-Features: AS18NWDFJ_osJRVbnAUraWGjWXB7TrxUdlg8pq3rQrOexAxnp7yjh67liY3VHfc
Message-ID: <CAGudoHHNhf2epYMLwmna3WVvbMuiHFmPX+ByVbt8Qf3Dm4QZeg@mail.gmail.com>
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Jan Kara <jack@suse.cz>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Mark Tinguely <mark.tinguely@oracle.com>, 
	ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jlbec@evilplan.org, mark@fasheh.com, brauner@kernel.org, 
	willy@infradead.org, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:51=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 08-09-25 17:39:22, Mateusz Guzik wrote:
> > I think generic_delete_inode is a really bad name for what the routine
> > is doing and it perhaps contributes to the confusion in the thread.
> >
> > Perhaps it could be renamed to inode_op_stub_always_drop or similar? I
> > don't for specifics, apart from explicitly stating that the return
> > value is to drop and bonus points for a prefix showing this is an
> > inode thing.
>
> I think inode_always_drop() would be fine...

sgtm. unfortunately there are quite a few consumers, so I don't know
if this is worth the churn and consequently I'm not going for it.

But should you feel inclined... ;-)
--=20
Mateusz Guzik <mjguzik gmail.com>

