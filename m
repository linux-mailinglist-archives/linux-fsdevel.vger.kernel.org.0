Return-Path: <linux-fsdevel+bounces-59961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7AB3FADA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20DE1A82814
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4932EC092;
	Tue,  2 Sep 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CITZmHX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA172EC0A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806120; cv=none; b=JdklpZRT15MEJU3wm0JJ4aA01UWSc8auJJIsocpBVKmsXEStK0S64putX/t5JrzMYNaEjF4I7V0EhdOPWIf/W2R84abtQOJ/AaC/s7o0uXP9IhGTS1Ycr38TgoTId+lhzF79k6jSQKqLr6qzQIHxJ88Eaf/aLIMrhf1PxAi6GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806120; c=relaxed/simple;
	bh=RHiF861gKpkMeYSeBsPB0byK+WOChxCRtaYlJY+3V/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkqPYmm5AF6zpkjLKOEVwJXNwJqn39CxzI/SvSTHITbV/JdvYEc4EvYaSGV9Ib7mjCykIbyzdjT0XolA8oe/e59LplUmwC5xt5Xh2pHEc3iwXyzBK/ml3sT7FIaNzj4w0riN8erT9VchX+zyZOdcIEYlhmMPN2gzOU+JvZOtkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CITZmHX2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b30d09dab5so54621461cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756806117; x=1757410917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0JzoS6XhQ5MVsd4BoVAtH4PmuwlxdD79t5dUv4exBU=;
        b=CITZmHX26+ZbewaUeNCZI7HrjZkfSWh+C9oNudWCVTXgzqVX78ZU5pXZSIBiAaOUfR
         o/qPxlRpPdqXM1gTEAGONZeRtYtRRemLfW+2YczeL+NwQFVzyw08WzXmNraDdmaFOqj3
         CXzR/RN39reFG1Q/kPb0HGORfIIoMOuRJdjNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806117; x=1757410917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0JzoS6XhQ5MVsd4BoVAtH4PmuwlxdD79t5dUv4exBU=;
        b=TlJ+c6voReTr9DJ5HbQvWWHvZ2G+yYjgCbPpQ6nwXQVD0zHvTpUtW66mB4GEwU4nwy
         709NFofNFcEaQrSa3YWMmRvwy5y2Y8r1BAykqzHzwIELFXdA8VoTCeENr13mpgevTj/t
         Hi6lfoptPbHPIRZbl0ZamSoLAkVV2NMB6TeGe3TkBl5falDxLRZTqRhdK14E1Ip5Bd5p
         msbazM40Z5NbkYrhc8sk7bbnHpaifex0aI9PvoJx4q39n7OPb2qeMlu+2nPTL3zExqOL
         LwdCDLfhhxDAY9OYZhns4PqnS7Rx8P07iDhRF8LlGbPss5kU1rKg7+m0cfE19pO4inDd
         eapg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFZpdMpNcJYrNei+NSI9/uZzEmZ/DOMpWgHVTzSxtKyQfqRbXYnE2Tq54iq2XM2WE31x9kiKZwWd2w4Uf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1912kYxc9hoTzaJFfNcSyDfoH878DuS1W+OaCjCUgn9fUBKb/
	9ikv0MJ473GnivQ+Ne/qr0gFx8TWOjXvqlX0d+Cw1P/ZGDYAERVCSUev4L1pNj6O8gqep1IRiEr
	KMfgSCRdYJqaAOdCQKaczwCoBYJTN7OQwAfwqCZAkZ1Mqe10H9kK0
X-Gm-Gg: ASbGncuSJSr39No/DDyv3hR4dGoOU8nrgFE/x1Qx+NEqX5nqkPensLyiUg2r2b1HiM/
	A9lXdCTezL+BOuCBWMZXIVsUPZuJeN5Vut/mFgp6cVX3K0GEdp2yAiOgRVRXLB4UmzJPS+4PjT3
	JnjsruD23b6Cqyb+8NBpdzc+OK073attjHWVPbK1fPdXGJ44DbaFGFfwNrTouXt0O0j4skvARWk
	pyH91Et7EBIPX3u32eh
X-Google-Smtp-Source: AGHT+IE+uuy7x1qSYV8OFJy8HLEp3cT3thfa/54D09nbahQJAP3PYTVbOvkOtUFQkfldb0THPciDoOF6whuKA1Q2CRo=
X-Received: by 2002:a05:622a:11:b0:4b3:4353:8069 with SMTP id
 d75a77b69052e-4b343538251mr29687311cf.34.1756806117087; Tue, 02 Sep 2025
 02:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com> <20250829153938.GA8088@frogsfrogsfrogs>
In-Reply-To: <20250829153938.GA8088@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Sep 2025 11:41:45 +0200
X-Gm-Features: Ac12FXwBE40nm_6y791f1Xi-pS2bpQqU6kTP5RGa4xeaIcDf1y02t4BL0C5gOis
Message-ID: <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 17:39, Darrick J. Wong <djwong@kernel.org> wrote:

> IMMUTABLE | APPEND seem to be captured in KSTAT_ATTR_VFS_FLAGS, so maybe
> that just needs to include the last three, and then we can use it to
> clear those bits from the fuse server's reply.

Hmm. Fuse kernel module passes IMMUTABLE,  APPEND and DAX through the
fileattr interfaces.  I.e. it doesn't query the respective VFS flags
not does it try to set them.

For IMMUTABLE and APPEND I can imagine the server being able to handle
these mostly (i.e. reject ops should be rejected).  It would be nice
if the VFS was also aware.   I wonder if we can fix this at this
point.

As for DAX, I don't see how the current behavior makes any sense, but
again not seeing clearly what the best solution is.  Currently fuse
doesn't support DAX in the traditional sense, but does have DAX
functionality in virtiofs and in will in famfs.  Is this flag useful
in that case?

I also fell that all unknown flags should also be masked off, but
maybe that's too paranoid.

Thanks,
Miklos

