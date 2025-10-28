Return-Path: <linux-fsdevel+bounces-65923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C959BC15197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848941C26191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38E34321C;
	Tue, 28 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkD9PecY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865A339708
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660302; cv=none; b=HLho5j57LBFBbxYEvyzpWBv6qTHGC/20u6nwVEAESxITlXETE79NDFT2ZkB5HiJlCrcJ5KeWjheohjD95mselZnJdF1xc/OqJtJZdwBJGxW37f2ExCcMcLtWwZBDWI7hQ2YV1cX/c9D/a0tlzkUHwOMAi7hdMHr6kvRRZcu0urU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660302; c=relaxed/simple;
	bh=XJNXAFxZiK88cHz3NFRWbJYZtmI5vkRXCxubdq9iJNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQbRcsNAKnAS8v4qfzPUNMmCdFWBCtNXAIAf93yD05R1CqYSsgtAeVM1kh/GvzYnk58qn8bjiV+ZKp0pvF2esv9PpRK9Ok0A45r0eTFC4BsuYJE5z7PlxmP5eQSk8ER2RwSrPW9J+b4Y+id1a+SjZYJAVnwVQP2yWqnFRY2HTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkD9PecY; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e3568f90dso6245885d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660298; x=1762265098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=LkD9PecYZJCjpN81Xp8B9YuIdXawRmUkLPFYl5OV4oN411bhpSHRDj0WgIRDVgMA+2
         rt8yeyDnCpeG1F6Qu4K+Ns0oYJuNmuEPjnA0NJR/eAvgiccf9rDmkXG+Cbkt8i3+FQiW
         Hb30KZacsgjYXqrX1++nRbU3aofjx4BHnkH0j+ZBZBobTJs3s+K9BZjYsq4du/CF5rDs
         JfLL3A7auKDgK3fsnJplkRf3hQu0C7JUt6cCrTDaMrjmsM/oVPK9kgxXM1Df+t4pt4Vp
         xf+rGMhZZuDHRtSse0fQUp4svRhLOC47JpJv0OMcMRLS7bte+auvFiZ8c3SXHvP6BZl3
         D+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660298; x=1762265098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV6lq40DHC8JcmNfWL6yF+Abxx6Ldftej9yA3XYbJaI=;
        b=ViFkZLivtp9NU0HgZNKQNVpEpe4e8qV15XCnbUAtbCbD/KMFBJ+xMZ1f95cYD2gXve
         pZjWn856PNYP/KSqNs7Cly23OeM9jsZVcB6geHaKG1hTFlTfXPoGrXFHp18C3zT0tXH4
         kc1P+C8cRJR9Us+Lay+mCNg3FXWZgQl0PEeQgnSgoPIcqAuSaeO2C/Hkf3+ebd++wnCr
         6o0f8V670lD2fHRXetJO4hLUfG0dEqGvW5FPVxJpiUM8qRtrgr/tzcq+t9TeylV8XvdI
         XCnVZrKoTRJu+gKuU4s1URiz8DvzAf5ZsWhT55gOhGi/VN3uQuZaRw9a1MIagMWsbDAj
         +S5w==
X-Forwarded-Encrypted: i=1; AJvYcCU7OML3plcYmw3TUG4jy1VzJJWeYSUwEdlXr2O/OE1J1SshSWjaQ0ViGqUA0GTkZM67QTVfeqoIAUdzhRCF@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMzrA2kK3uDPPebsL+sVgrLiCc2zbo4OPbQ34DoL+UwJSsjpw
	h/cAFNzntfbYBopZ1m/4kPXFlWbReSBXZ/7BZDLIjppU4Eb63AERZ7YaOLYhlE7wRr3IRr22aY0
	zBS+xs0xzSPD3amN6wVUBtc1E1QExT+Q=
X-Gm-Gg: ASbGncuorpSxJ00Xy9GYq2DHX0A8TEdBEbYyePZ2SZwbdEwk8aTMwFIZztMUM5bqkYz
	amzzxdt139NnG67g3A0xYOu/GV3bZcIsSLPaLhMge/Xug3/guZ/7yPeDBhYWvu6YAogXqHzvjoy
	GYf4BQX0NVqsMwH9S3nFAYsLR3lsEJ0wcne18B6+ZFjYRMwpytPIaRzhwzeEkvs0WJcSMvb1UqD
	ukljP1PGnPt1VXAKEeIDjS8E/nvDlRHa/RdROgivCEiE1EiUFhv0pB+pdDSACqv8uBdoTDPBcRF
	qntuBjpefucv4cnMlg==
X-Google-Smtp-Source: AGHT+IGO59IsEPrMaZUmuz6Z8HqEjQzA2Ntsc7bvDVyVXUheTpOGkWA4zrFX+wmhIbJUO+iBKxLOdRdY9YaXu1dEED0=
X-Received: by 2002:a05:690e:d83:b0:63c:e90c:a6d8 with SMTP id
 956f58d0204a3-63f6ba849bamr2974242d50.44.1761660298140; Tue, 28 Oct 2025
 07:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de> <20251027083745.231716098@linutronix.de>
In-Reply-To: <20251027083745.231716098@linutronix.de>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Tue, 28 Oct 2025 15:04:46 +0100
X-Gm-Features: AWmQ_bnQq8Ze7k4D-80utHvwT6MTXau8I1_bRZ4nLy6wJZW1-jMkY-uZGE3OIrk
Message-ID: <CAKQ1sVO9YmWqo2uzk7NbssgWuwnQ-o4Yf2+bCP8UmHAU3u8KmQ@mail.gmail.com>
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> +
> +#define __put_kernel_nofault(dst, src, type, label)            \
> +do {                                                           \
> +       __label__ local_label;                                  \
> +       arch_get_kernel_nofault(dst, src, type, local_label);   \

Probably arch_put_kernel_nofault() instead?

> +       if (0) {                                                \
> +       local_label:                                            \
> +               goto label;                                     \
> +       }                                                       \
> +} while (0)


Regards;
Yann.

