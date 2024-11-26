Return-Path: <linux-fsdevel+bounces-35909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E341B9D98DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A903B22737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871841CEE96;
	Tue, 26 Nov 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m3fyimUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24D193408
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629048; cv=none; b=ZoTOxklp4XJHrBdHYpk54hGBMptAip8+V0f7gFHePU4MP0dK88nDnP/9X+QfQjE5m937j0ithOSTSsyoOSnAFhtTcbwIoW62XR0kvCtGJHAPYr20BUqwgk2Ba4wVKHcD8CYSGEr+czfedJhUtpVKKo71Xz2cp0SPMRDp5kTMSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629048; c=relaxed/simple;
	bh=rHa2Pkh7li/QGEhGcNYZNveFmh5qRI5DCHiWMi+k3g8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glxriliTVzdIo1R2q4SW1piYOXNNQl7G5H9zA322897sgA5oKMZrUNidqvNe9gL3EyajaTgjlxb31uSfA0VqU17WL0gekj39y+EhuQPybaa0kIk+NdEA7sKCIU4jL4Sg7wI2In2LqfY0eW9hPCFGaUdFnQ9Ds+EDXCQS+Sn/g6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m3fyimUG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rHa2Pkh7li/QGEhGcNYZNveFmh5qRI5DCHiWMi+k3g8=;
	t=1732629046; x=1733838646; b=m3fyimUGdmhmwFcydwceorK7Kd6u+aR3lJyiMANlTcCiDLd
	H3FGJmNWFJXJ2nYoh4uwGEK0/hQn2ouG5fw3pFm1dxREXTvGAx5NttgtbBwbgRN30RNXd0U1gBee6
	gAdPqNPe4IyKM/bVoshZ0VLZwmbUrMyhoX8EQoGRbO1UnTIikX8DUuPsYB9g/HXuQbA8nyRR8yfM9
	3pJApPkMCizYqtZ7+HYazsAXcmojUG2vLmq7hQ8MVSdbxuzDlzl/BgUvsWvWa/6/hLfvwmHFsWbba
	fwTjtgmyi+nqNQXQUU/2BYddFALNRnfkN3x6xDOq8whJcKMUecvLAbPzIAqWPOlw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tFvxe-0000000FT0O-3euF;
	Tue, 26 Nov 2024 14:50:39 +0100
Message-ID: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Zak <kzak@redhat.com>, Hongbo Li <lihongbo22@huawei.com>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
 rrs@debian.org
Date: Tue, 26 Nov 2024 14:50:38 +0100
In-Reply-To: <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
	 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
	 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
	 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
	 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
	 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
	 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
	 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>=20
> The long-term solution would be to clean up hostfs and use named
> variables, such as "mount -t hostfs none -o 'path=3D"/home/hostfs"'.

That's what Hongbo's commit *did*, afaict, but it is a regression.

Now most of the regression is that with fsconfig() call it was no longer
possible to specify a bare folder, and then we got discussing what
happens if the folder name actually contains a comma...

But this is still a regression, so we need to figure out what to do
short term?

Ignoring the "path with comma" issue, because we can't even fix that in
the kernel given what you describe changed in userspace, we can probably
only

 1) revert the hostfs conversion to the new API, or
 2) somehow not require the hostfs=3D key?

I don't know if either of those are even possible


Fixing the regression fully (including for paths containing commas)
probably also requires userspace changes. If you don't want to make
those we can only point to your workarounds instead, since we can't do
anything on the kernel side.

I don't know the fsconfig() API, is it possible to have key-less or
value-less calls? What does happen=20

johannes

