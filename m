Return-Path: <linux-fsdevel+bounces-63395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102CBB7F27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 21:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1934A8265
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD518A6AD;
	Fri,  3 Oct 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b="N7eHQQdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nERDKEfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0512E1E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518113; cv=none; b=rxKMjvk6vcKbcT0hN+Q4Ho1Nqf+/yS7YNNHK3v0dsbYgceJcac+d+amXakc4bKArlIbJDb2wCQxqO/SNTKBHv+rNscLLw7mVh2arXUXhZByvx3BqImj2fJ4DeaUFXN7OgEdpFDRAJSCM5qUM0gYJwGeMLItv9TIPFKsv4im7vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518113; c=relaxed/simple;
	bh=fAESD0xt5PDOtMe/OTDiIdCzE3ko8ptcxV9mqYhXLYQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Kd+WYMeqTNBxHHwXUZv0ORE5XLkul9SYL7eIlwgExSgjznPaXg0I4/aQjg+cJKHrZz7pc5IXS716XPdKnYu7G61NSCbYyvc/08ljmstZnNdB9a2d//lkA15VhCO6vRuVdjnOt+bFqJnvQNSCG+cYCPaDSnV2RxKaMQOlpgSuWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li; spf=pass smtp.mailfrom=mazzo.li; dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b=N7eHQQdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nERDKEfE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mazzo.li
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B75717A007A;
	Fri,  3 Oct 2025 15:01:49 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-05.internal (MEProxy); Fri, 03 Oct 2025 15:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mazzo.li; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759518109;
	 x=1759604509; bh=87biOegKfy5ZB95f/XtxaKY5KyoML/0rFh/X4Jb/7so=; b=
	N7eHQQdCSElF53uUdo0zOVIIAulDCJjnZXOjbfimWWlJnpUw8U1vHRAlTJnBgKPi
	zqPiJ0OOsOvR00i53S7cAJJLzGFNRqmB3q6VE7KgdLj8fC2s+8x31xmLgy7WUwlg
	YbGHbNqAxEHDzkvD/wI8JfFzK3rXD+K3+wqICSsCelgl3uZp7ljZWhDA2n5KAOYi
	AOoIKCi+mJG4bpNhaGC/5sGPO6BMRN9UGeawLHlLH+qBTtgzwYPwEy76QbdVfqk/
	K9fCrsu0ZmB465T6OJPZc7/3EyGhD3DwzR9ovLV/AZZk8zA7/AWZcFDx9J5PNYbM
	aKQ972zZd/ZdnBpGOnpbiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759518109; x=
	1759604509; bh=87biOegKfy5ZB95f/XtxaKY5KyoML/0rFh/X4Jb/7so=; b=n
	ERDKEfEueUHBYivZBim7ckG1fI9a9bQ40Uw6zRylmO8LvSPd1TxILjawRGGo98k1
	/mbx1jBD3GEPAiWdcyIMEp1BkFtmqgwnhJKr503OVebaCKAeJtM1LYGI6q/e3mJ0
	XMdtPMYLogTv58olQd608kv8AB5dh7L9Vo+qfqAjAQSoRMagkCDH5+gOP0aZlKfj
	K4DBbfbLOj+1MJxj9KBQJ5yhd9V7GWZP/l/cEM22CpYiW5/POZdU8Z1dWb/kEqiV
	8aaB9ZAKgpNs9j0U5jcOcq3jOvtw/mTaVaa7BQPaQM7xSUkysw8ZXIwLCe4naqx6
	9zPGVpeKGeO2tWPT9lN4w==
X-ME-Sender: <xms:nR3gaHYdDQNF9UQ-B43AgDViSqQpvnsbuTrqyIh-LC58gUak1t8z-w>
    <xme:nR3gaBNjZG1D9MsPlJDPqYtc8Om1P6Y85kzC_zJn14oBIEFbwpKix0YbIEDjC-nWh
    8gOQAWudxx2UkMLTCeKDa17BH8jwRg7bBfTRzkB3NiXPjV25gtb5ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfhrhgrnhgt
    vghstghoucforgiiiiholhhifdcuoehfsehmrgiiiihordhliheqnecuggftrfgrthhtvg
    hrnhepffejgfevkefhiedtgfehudfgueeiuefgveehgfevffejveetfefgfffgiefgfffh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhesmh
    griiiiohdrlhhipdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdprhgtph
    htthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nR3gaPENbFXjOjVNguhazJ-GV5tyY_mACap6uHjjy26dRcGpd0VSXQ>
    <xmx:nR3gaFrloS8lXb98ETq0zJL5qnjrdu0btiWJIJ8iYYzw5ZTHASqwYg>
    <xmx:nR3gaIZSa506wuzXVb69FO89-VVz7YAs3nrQKH9AxGPWJGpTw3_l_Q>
    <xmx:nR3gaOWljkm42Y2lRGPh1dq44j-iUsKsJ7XUOMtqJcrmH4_tyMg7iw>
    <xmx:nR3gaBTxZYa9LNV-prddrkHMahB9JtWw_22Yzjc2JCMvESJQS9eAFcOt>
Feedback-ID: i78a648d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30D50216005F; Fri,  3 Oct 2025 15:01:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLrIgF2TFVc
Date: Fri, 03 Oct 2025 20:01:28 +0100
From: "Francesco Mazzoli" <f@mazzo.li>
To: "Bernd Schubert" <bernd.schubert@fastmail.fm>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>
Message-Id: <b9fee7c9-b3a0-487a-aa97-7f2e0b8e8d04@app.fastmail.com>
In-Reply-To: <8e7a527f-2536-45d2-891a-3e203a5011ab@app.fastmail.com>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
 <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
 <7747f95d-b766-4528-91c5-87666624289e@fastmail.fm>
 <8e7a527f-2536-45d2-891a-3e203a5011ab@app.fastmail.com>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 3, 2025, at 19:18, Francesco Mazzoli wrote:
> > I agree on copying, but with io-uring I'm not sure about a request queue issue.
> > At best missing is a dynamic size of ring entries, which would reduce memory
> > usage. And yeah, zero-copy would help as well, but we at DDN buffer access
> > with erase coding, compression, etc - maybe possible at some with bpf, but right
> > now too hard.
> 
> I'll have to take a look at FUSE + io_uring, won't comment on that until I'm
> familiar with it :).

Oh, one more point on copying: when reconstructing using Reed-Solomon, you want to
read and write to the page cache to fetch pages that you need for reconstruction
if you have them already, and store the additional pages you fetch. Again I'd
imagine this to be hard to do with FUSE in a zero-copy way.

All of this should not detract from the point that I'm sure a very performant
TernFS driver can be written, but I'm not convinced it would be the better option
all things considered.

Francesco 

