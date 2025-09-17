Return-Path: <linux-fsdevel+bounces-62011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF79B81C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77BF4A4F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F452D662F;
	Wed, 17 Sep 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E93ViBQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47228BABA
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140749; cv=none; b=g6uge/Fns8sd4yGLNlDOy0RMuEOvKaSMfz+ZOZZDVAm4KE7d755ROs9JTbwHbkTgIedOZ6iUb5Q8d4180bOJx+aRKGiGfA/GTLj1JOrCZECMu0HY+s+XrbFpP55OJusEoMIM3yiPy9humEv2pjP+Ngg44qh0cVJRFi6fxPAb03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140749; c=relaxed/simple;
	bh=K6d/jzhMMI4CPpQDgjpBmEl98KL3cG+euC4yxGzEVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPcVHBgUoRRymFmyFeXXPpCFl1/qz+1RmiGEwFOBYBrJyX5hWXptBu55AGBc2LjFh+XeH5qmz5tlCU3FGbBivgnv5qvu61dBRknGRCFbJE7zPpT4J4dVhzL9aIdLJvTe10hww98+FkcnydraUqiU2Ln/V8nTsoap89Qj7EDElPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E93ViBQr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a16441so35012766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140746; x=1758745546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=E93ViBQrlMJp2YF9PBilI+D4r4dqMY3kENfrRihA/DLYVvQ3tFSLBlr25yGkNQZSeR
         EvQ7C8EP9iYqCNcBmELAqwIYVELvBY01wXh1NLNH9pQelcTa3DBev1jJ9ZHywMfyQxiw
         jMskuvUL5nGW6CCje86E6qhKG7P8MZmMivlYzSl8zDKmxPEz1hyVpavb2LVlVOkvdWvq
         t3mPCff8/kzD1pdYyXAaFS5AF5PgHpsbs5DZiPHn0GSw5470xGRJN8PyzjDov6RbA/pg
         +ABF1T3cG5N6e6IE/Agbc6raLoM9Z7HCVkzSaFJMfkFcaUrwPUh4WxDRuf55acq4s8zE
         BmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140746; x=1758745546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=OMupfHDzmmnOek5JUyscsP9/U1+y4KCXwXUyBpAJGdTh/67salGmQvdAWtI+/XC/7G
         cyzEbu+4gW31hrNzCczx6vRL8cN36F3DHslauIRtgyBr5MvBwHC2WTzToSmEWC88CWni
         Pj/od1167DX16sPWJkEZXqqDnLGLVYNc3MpGFl85SLeUIRBTLraphVfp+tD+uhiokZ+h
         F4hyamRktHpx48RH3Ry03w+MPNBtTRJGi6numMloM1S6BI9D8Ykw7ujyfutK8P++8Rw4
         S6f8QXnSedUGJWrMtvMEehcpBkJLNvQHTvbo2l/TmnxVmbSvqvKGnTero+AL6H1MfiaD
         lKzg==
X-Forwarded-Encrypted: i=1; AJvYcCWyEtTR/XLkKdWjjs8GDBug0FzWtxUet0o/Ef/RWqDIXuHn1cwhhME5kH8vccDlhJHFfRa3OFQn9Cpa52m3@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxWJ0EwoMEHTr/9Mz/emU2InKR+2Svo5Qe7z3+1h7+LRkTKdb
	YVCCKSQN3ow3eJEUphHaMHNsguU1CuHY8ukwbjV87TFhTgUopr+0TXGgyKfkup5u95HnEjbkUJX
	M2ucnagxWNa/gK3sCEj3DJW+93Rn/Sz9GU8eqs1EVpg==
X-Gm-Gg: ASbGncuEd6LNSnQC1TB2Ho8uErkjpZrmk+ka0vRv17AlR4xsZ3NgeR1aW0Ytttr4MpN
	bWzkQ0O1Wp25HWDvfmoAZ3WRyVAZtIZvffdfXwiOamb5sYpepS+E3ibaI2X7vykObR6GHVVpC8N
	4Z0HyJBPK5Dy0gP+gi7SN2+Ij9yTicCkkm9m4UApu86480j7xbI102CTf9O98CPL7pwPbqp8sJY
	uufjcSGepcrHvoTAKdy3R/lhHZ/+bY6LqcGmeAP3jVmBN8uOYSauXnyLwbfdMGzpw==
X-Google-Smtp-Source: AGHT+IFBvtsDmLFlrUPLrEdtXlj3XmnDOunMGaQVNwpHnx7V9K8cWA1KerJzVQIV4Og+xzCob2fZntJ3zIqyp+GB2lY=
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b1bb6048f2cmr368398466b.20.1758140746182; Wed, 17 Sep 2025
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <20250917202033.GY39973@ZenIV>
In-Reply-To: <20250917202033.GY39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:25:35 +0200
X-Gm-Features: AS18NWA9lLP5Eqngelj0xlWoIoGVHH7XtsnclhYX2neNhHDUumPEaBrniNeVLQk
Message-ID: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
>
> > After advice from Mateusz Guzik, I decided to do the latter.  The
> > implementation is simple because it piggybacks on the existing
> > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > iput() at the end which means we can donate the last reference to it.
> >
> > This patch adds ceph_iput_async() and converts lots of iput() calls to
> > it - at least those that may come through writeback and the messenger.
>
> What would force those delayed calls through at fs shutdown time?

I was wondering the same a few days ago, but found no code to enforce
wait for work completion during shutdown - but since this was
pre-existing code, I thought somebody more clever than I must have
thought of this at some point and I just don't understand it. Or maybe
Ceph is already bugged and my patch just makes hitting the bug more
likely?

