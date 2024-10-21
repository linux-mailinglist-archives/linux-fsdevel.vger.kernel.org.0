Return-Path: <linux-fsdevel+bounces-32497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB389A6E39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B625B20D04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938741C461D;
	Mon, 21 Oct 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="OsFM8QjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868C1C3F38
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524832; cv=none; b=KOyU6nxnkhXsdtDWBwKX4k/Hwy8vYmvCB1qGKrkhNUr6xlasFUAVoLlmbRawfG5ogXSfk37M6VU/vdh3OS23DH6UwXt/0Vm8hP8Ag8qcHhCQdkpyJTpI2qJfAF4sE9j37GkzR1RaocFFPtBUaaZi4xN4i1mbf1LXIePLUPN0ceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524832; c=relaxed/simple;
	bh=VWNA2UPZManT4e8IzPJGTVogJGHNxZC6DgA458N3a1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Xw9cd3Wej+Lta1En0vZKZmBkPtyv3ToebgOSDowsg4VvsSRWNf+lEBoTUYlNfhFpcUQMsxuYOCE93sC4cvMZzRiisKtZULp3Pa868X4kXy4LqUX2ZApIMWXcspI9D+Ma27vtizN1Bq1bjyHTbqlkNSbAf8F8Vim6QASKhMMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=OsFM8QjH; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: d83529dd-8fc1-11ef-a834-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d83529dd-8fc1-11ef-a834-005056ab378f;
	Mon, 21 Oct 2024 17:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=4/64ineT8w75TdFchzfMizy0mxnyBI1Pdn2/3uXzmMY=;
	b=OsFM8QjHjIzEq/XgnnTVf9ssPnOYjXfO0g/ec20xV6dxl1x/OBLXAxOWR1j6/SxUP7qDH0koGVos2
	 cK9GWyB0ASyGLHmV4bO0X0XRzscoWg5DxfWfMNBMZpdCuV1p6/28qJc5wxdGuBbDHh8Tdddwbo9i1b
	 6KQE6XIHpLb7ZqKo=
X-KPN-MID: 33|5DphU59EpAMuFP6KbPgQlj9lTqYwSZkAHS2tfNFnM+YlGdsWosM1b5U/2S98KFi
 a2rBSTs6oaGnlGBp+4wcbgdV5mou4cBBO5CqDYYM3ijQ=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|2qaZN8mjL/1Wpi48lWOqlMIKNjeUzXHdsjR26I9XcafS2q/YTJjq45dN0DHOfvp
 fdBrudRg/S/GcCcY7C2fFiA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d89c4870-8fc1-11ef-a2c7-005056abf0db;
	Mon, 21 Oct 2024 17:33:40 +0200 (CEST)
Date: Mon, 21 Oct 2024 17:33:39 +0200
From: Antony Antony <antony@phenome.org>
To: David Howells <dhowells@redhat.com>
Cc: Antony Antony <antony@phenome.org>, Sedat Dilek <sedat.dilek@gmail.com>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <ZxZ0UxOsa4WvaBku@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <2156441.1729519958@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2156441.1729519958@warthog.procyon.org.uk>

On Mon, Oct 21, 2024 at 03:12:38PM +0100, David Howells wrote:
> Antony Antony <antony@phenome.org> wrote:
> 
> > When using the nix testing, I have to force the test to re-run.
> > 
> > result=$(readlink -f ./result); rm ./result && nix-store --delete $result
> > 
> > nix-build -v nixos/tests/kernel-generic.nix -A linux_testing
> 
> Is there a way to run this on Fedora?

Yes. You can run it on Fedora.

try these steps?

1. Install nix.
  a: preferd way:
  curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
  b: may be use dnf? I am advised dnf is a bad idea!

2. clone latest nixpkgs 
git clone https://github.com/NixOS/nixpkgs

3. cd nixpkgs
nix-build -v nixos/tests/kernel-generic.nix -A linux_testing
currently this will run 6.12-rc3.

when the test does not finish running,  "Ctrl + C" to sop

when it succeds to re-run:
result=$(readlink -f ./result); rm ./result && nix-store --delete $result
nix-build -v nixos/tests/kernel-generic.nix -A linux_testing

-antony

