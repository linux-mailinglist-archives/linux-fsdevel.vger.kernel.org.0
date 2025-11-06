Return-Path: <linux-fsdevel+bounces-67345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB355C3C49F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C9A4EE0CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90F032C92B;
	Thu,  6 Nov 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEyqOps4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403B302CD0
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445294; cv=none; b=vCAXK/r+WqVZSmHG3INRKvlpL4PjFrjRKf61Vgoh9QlMMRPbTlQBBULE8l7TJEfHigP+mGjJUuHHfkDVEqElcjTiF+N7O6sfuKr63QSeG1jXGzYlQe4vrmRTiLeTxCHu487eeTAx4iqK/1jjkpCbX8FI4zjUg7Y6yJJ3YuygxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445294; c=relaxed/simple;
	bh=laKqait+cSw79exUwq45fM39p/9bpuzRkaDsWou+UUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBewiRMReInzNtaeA5fdMcEwP1gqQ1mumvo25Y6TlvZfQcb6wNIdpefKnlecITt3mZbHkHNDPIxZwUDyHxKztr4T8ZD9fsWDsyQeb5aMBUuqJRtUD06CMpHQzXWRjPavpo8oLVmtj1h/A/n/OPc0l+UFup4qtj1OLywO5rdsALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEyqOps4; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656c07e3241so521505eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 08:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445292; x=1763050092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=laKqait+cSw79exUwq45fM39p/9bpuzRkaDsWou+UUM=;
        b=QEyqOps4ZPuFaxNwz7qVYBfteyeM5Rbr7S55xnO9XpfQR/7Wyu5DQGDCcSqyaze3DO
         r7MhlRfD+df7X4EU82uCXbQWZthhE7QqMXd2z5ef7OUYxg22DuqRvUYNpZKAS1k8AX+A
         u468RyAn1Wb8QXkwaJDNqG10vvrjUl3sgEX/XLJX+fdnUKbWk58fty6F2V0OPIooqf8l
         jL4vlTrN7M2irLqxcReIUBykLsJ9HBRjt4G4aPhjBrTpcpJaTrT99yKywkwRvVKmeI5G
         8Pa1Aw4mKLd7+kgh57FAKSIgvkUHgOWfmKV4vElxDSmT+NWKerA8CjNO+HCpe8BD/Cx+
         S7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445292; x=1763050092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laKqait+cSw79exUwq45fM39p/9bpuzRkaDsWou+UUM=;
        b=kji46dbidSj1j0H4hCH2EXq+igRSJmm9Idahez/Q545wc7JitnkOptJEYiaC5R8LHS
         mKF4ZY8zgYBHw6s4l7Pqt18ju585SvHD/wYVXrupbxcpuYqwG8J5NxPxQuWV1zrXYcH1
         G7da+QY4mhWCS4Bd5uKCMD+Ba+fSFf1VWUk4xcx5StE7pzroa/0SZpDZ/r1FLa0vIDeT
         InbCB57Q47YWzwWRK/GdMimM1iWdHRRVrI2Qtf4oC0DksS822GlXomF6wGERkfdfDZDr
         mMKqT59F4CyeBNtEZdWzmIehRcC+Hhp1GLUGFxsozxObiF7fF9YT2jhYwMFabLz4kx5U
         6Hrg==
X-Forwarded-Encrypted: i=1; AJvYcCV7iSSrCFB8Vfc2i9gTKB8Z9ZMEHBs/yqqMdCL40sLKA10xHNZEBKFrS75DsH64NdwwkPx4bOwKlBZSyMPy@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzWU1vgDGfoVPlCjIfC7T3xJqXrUx7URfQuihVypqlfl9P1G1
	s8zgX7agcNwUmBJqL1Dl/VuL+bp1m9OK/M8U/uusZVvN5KwP6YQ777+bd5Rm8hEMbEmW3N7+dX0
	WkoIEoBtODWmk79j27Qv20go40jC78g==
X-Gm-Gg: ASbGncu8avQQFQL5yi9vGvxmmn9BgTrQJ5RYUYu4lnegW8unahfWNiiZR8tUDSVRC9C
	IXmXBymJewUJpkW5g1pntdkIIJqu8hW692im+zHUHdXsi5Ih8wX9fMb0E13W9SGra+pcQwqiFCl
	4cFPmQnNgf64Q0YLf/wnMWjWP8e8hLTJgx4+2DAhvaBjJRu8ZWmXkGW1ACL7Yf+dphyL5LsYGjJ
	GKU1+bKTnEvbFbwaxiUt5uFXKqZ9CoRe5aoX6e3+hePst6huT+v57iIW2k=
X-Google-Smtp-Source: AGHT+IHyJijhtJc3B6Ll/keF3ITIBKwvHR+4JfY8UpBRpeV1p3eRhyLieZgGk813hMSy2bjRq6Ou2YEbk+ereSr7dmw=
X-Received: by 2002:a05:6808:c3ed:b0:44f:df33:7682 with SMTP id
 5614622812f47-44fed2e39d9mr3838955b6e.2.1762445292193; Thu, 06 Nov 2025
 08:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs> <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp> <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com> <20251105224245.GP196362@frogsfrogsfrogs>
 <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com> <CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
 <20251106154940.GF196391@frogsfrogsfrogs>
In-Reply-To: <20251106154940.GF196391@frogsfrogsfrogs>
From: Stef Bon <stefbon@gmail.com>
Date: Thu, 6 Nov 2025 17:08:00 +0100
X-Gm-Features: AWmQ_bk-wlOwiF1FtVQ0IxyYR48oRj3xT_blmrLDT_FvQm4nR2RCsvj0RKOoztQ
Message-ID: <CANXojcwP2jQUpXSZAv_3z5q+=Zrn7M8ffh2_KdcZpEad+XH6_A@mail.gmail.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

is implementing a lookup using a handle to be in the kernel?

I've written a FUSE fs for sftp using SSH as transport, where the
lookup call normally has to create a path (relative to the root of the
sftp) and send that to the remote server.
It saves the creation of this path if there is a handle available.
When doing an opendir, this is normally followed by a lookup for every
dentry. (sftp does not support readdirplus) Now in this case there is
a handle available (the one used by opendir, or one created with
open), so the fuse daemon I wrote used that to proceed. (and so not
create a path).

So it can also go in userspace.

Stef

