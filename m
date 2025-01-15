Return-Path: <linux-fsdevel+bounces-39233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69522A1199A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED1A1605A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DB22F831;
	Wed, 15 Jan 2025 06:26:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43E8BE7;
	Wed, 15 Jan 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736922413; cv=none; b=t5uVWGlwqHDYi/Rz1Nt9X/b12Nm46uMV2aPTyxnwALoSW1eC2JDPl5xnztw454zEW8tlk3SQ911NPR0RWFJlPSf2tVhKQUY1mRaWG2bFMEGrDkEirIDYokcBN1nwehbrHzEGBdysIDkd7D1RpM3x1BkA6lrMUSuBBOFXQNNU5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736922413; c=relaxed/simple;
	bh=3gBgxkX0iWCiW4IAUZDcHcBe/dY53nAJKL5hcEh8FNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LEwkV23FOzyW8wSRCKlPSG4xcHTz7JsJlxyUBwlsxu7xuHiNNDQp7ExWWzvmYofdEN+SY6Up2fNHBfvEzKndu+NU12FvvtWTtroEBvpgLeYbZBmPIFY2Ojt2LGM0O0cdbrKK+9pazt/R1tOe3ICU0xkPGIIWGXYss+dpHoMcXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AAF4E9200B3; Wed, 15 Jan 2025 07:26:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A720992009E;
	Wed, 15 Jan 2025 06:26:43 +0000 (GMT)
Date: Wed, 15 Jan 2025 06:26:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Darrick J. Wong" <djwong@kernel.org>
cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
    ronnie sahlberg <ronniesahlberg@gmail.com>, 
    Chuck Lever <chuck.lever@oracle.com>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Immutable vs read-only for Windows compatibility
In-Reply-To: <20250114235925.GC3561231@frogsfrogsfrogs>
Message-ID: <alpine.DEB.2.21.2501150625210.50458@angie.orcam.me.uk>
References: <20241227121508.nofy6bho66pc5ry5@pali> <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz> <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com> <20250104-bonzen-brecheisen-8f7088db32b0@brauner> <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali> <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com> <20250114215350.gkc2e2kcovj43hk7@pali> <CAN05THSXjmVtvYdFLB67kKOwGN5jsAiihtX57G=HT7fBb62yEw@mail.gmail.com> <20250114235547.ncqaqcslerandjwf@pali>
 <20250114235925.GC3561231@frogsfrogsfrogs>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jan 2025, Darrick J. Wong wrote:

> > Are FS_IOC_GETFLAGS/FS_IOC_SETFLAGS flags preserved across regular
> > "cp -a" or "rsync -someflag" commands? I'm just worried to not invent
> 
> No, none of them are.  We should perhaps talk to the util-linux folks
> about fixing cp.

 FWIW `cp' comes from GNU coreutils rather than util-linux.

  Maciej

