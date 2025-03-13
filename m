Return-Path: <linux-fsdevel+bounces-43918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A17A5FBDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CC71886E59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA6268C5A;
	Thu, 13 Mar 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="INiw/BY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8802E3371;
	Thu, 13 Mar 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883691; cv=none; b=oT3cEZHWIM60V5bWB3vcPi4555N3wtAaFukQMk2ijuJZjtI6lwnHfjMsTFMM0b7aiZ9RngPeRihmgWUxRVHqK8HWeN3RpWBN8Ymfhd53+vB7THi7asiCywZQAoKkeg9iLRVhvDDushHPYhZ9lQSGNks/ztbJQIA3iJk4sJa1syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883691; c=relaxed/simple;
	bh=5OKmSnvCdr1VFgeIsGzSe7XOU1tHtPNOb533sHEAdEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/VjJ0dcbj4crhs4imRDKGVo5fGDgrnuJUGxmzYtq6d87dbZPsI1YXQNQ4yXF8OdMPoFhkSxgjJai027+I4D6l9cz2A36eJuVpg9za6k/b+6HaEBNoSCh6cKs/x4TcijyeB3BVC+Ydm2gjZsO3WCOjzM6Qb/rvgCz6Zvcd5/O24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=INiw/BY3; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t3tspSjPWzUbZJ39HBMWBiuBDmQruoqd/+DIkFO7DU8=; t=1741883687; x=1742488487; 
	b=INiw/BY3EmpQ+tFbto5KJqYzmXRysM5GThjAhYsbCynEznpLPDo4LhdzdFBTwL58+EdxgvBmbuM
	028eFSc0XRN70eRuGNl4Y2n3tb+aKMPUE9fasaiQklBDFXoTAtx9Ivce3cjB6GFD/97A0/6jwFUIi
	l/pIQXAyGtXecH7fIk5k5+/QcTrpW78si4zwBrnWAlfyF8cJnxUqCdv8G+iOc7XeQTpPIgZ93+y4N
	2rkc9UKNnWUtUhihlBpWpcMvsN88bgThoKynEPt7g26UsXqe7K/GSSTglFEG0jRiH4HrvS+7n/L11
	isBuLiQ0KzfVqfA2EKk4XM26Qk5t+Dar76Dw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tslW3-00000002dFt-2bY1; Thu, 13 Mar 2025 17:34:39 +0100
Received: from dynamic-078-054-179-053.78.54.pool.telefonica.de ([78.54.179.53] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tslW3-00000000cJH-1fzt; Thu, 13 Mar 2025 17:34:39 +0100
Message-ID: <a25daa5d094cf613e2f52fe716a17edf9fb26448.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 3/5] tracing: Move trace sysctls into trace.c
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson	 <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Date: Thu, 13 Mar 2025 17:34:38 +0100
In-Reply-To: <20250313-jag-mv_ctltables-v3-3-91f3bb434d27@kernel.org>
References: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
	 <20250313-jag-mv_ctltables-v3-3-91f3bb434d27@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Joel,

On Thu, 2025-03-13 at 17:22 +0100, Joel Granados wrote:
> Move trace ctl tables into their own const array in
> kernel/trace/trace.c. The sysctl table register is called with
> subsys_initcall placing if after its original place in proc_root_init.
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kerenel/sysctl.c.
  ^^^^^^^

Typo, exists in patches 4 and 5 of this series.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

