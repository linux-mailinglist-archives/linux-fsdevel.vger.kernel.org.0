Return-Path: <linux-fsdevel+bounces-45941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7681A7F93F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D42E170AD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F7264F81;
	Tue,  8 Apr 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn9XzIFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CC2641CF;
	Tue,  8 Apr 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103937; cv=none; b=Li5VuE4IT2gc1ZHNlQe7Otm1VtT8o5WAMBRnsrp5RFQvoT3gy2MFAaOMwS3RSZc9UcWDHGVByQVRboiKg/fcHFDndAJWVxAN+9aB8PPR7fVNzyuxaisOXuu+bAyIfX/UU1qicEDQhScwKB7qk0YyoJD1OXVnj45vO8c+rYNeLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103937; c=relaxed/simple;
	bh=gdN27oqe8+qDCSK3WveLJNIwqSYAw2GA8bfzlRTA7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP7gh9nakmSc543Q4WoWapshbHtm8KlN/CNB1RDlhFTO899LHKIoYKdzUKVvJTpUsuWwG8fbtjn5wwAC6kD+DSxOydXfO8r1tLdNMo7UGmjP/bsesnyu/Rf1RBkwEU9NuSD4yMMrqu0PUaAnOUYpEQRqji6uRrtmyxNU/022g4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn9XzIFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43A8C4CEE5;
	Tue,  8 Apr 2025 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744103936;
	bh=gdN27oqe8+qDCSK3WveLJNIwqSYAw2GA8bfzlRTA7MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn9XzIFiynhT/cg7oP+0wJZhoMi+pEhYRyFHmwiRDMbYhwXcveDwUYaCrZ70TMeiN
	 epufLlobnej/RC6NRWqq5KAzYyjuYQLTc2787FLimbnqkQ0FzDVRAR4tsWI1gCsCPr
	 njlUrDFdGVjYEy3gbzVPWKH0uEb7nDjNgG5x7as+XXoe/Q7I6/UtEktOnFI6BJWK2u
	 kw1sNn8o5LP3AWZ86+v77mtO2kfJm9WEnhGmMD3Eq5vovHa+2r+7eAgB3G52pVy4Xp
	 jVkAo0wqXYt2M4pw5rYcY7IhqnxpT+5GBb69S+W/1fyNg3adwxmrYIF8mb3IQ+qdmn
	 1Fk+XYAkn9OIQ==
Date: Tue, 8 Apr 2025 11:18:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	lennart@poettering.net
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
Message-ID: <20250408-vorher-karnickel-330646f410bd@brauner>
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner>
 <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
 <20250408-regal-kommt-724350b8a186@brauner>
 <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>

On Tue, Apr 08, 2025 at 01:50:16PM +0500, Mikhail Gavrilov wrote:
> On Tue, Apr 8, 2025 at 1:24 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > I have a hard time seeing what that would caused by. I'll try to look
> > into it but it's not a lot to go by and this just shows a hanging FUSE
> > request which seems very unrelated to the change you point to.
> >
> 
> I could perform another bisect and identify the subsequent commit that
> caused the issue if I could revert 474f7825d533.

I'm confused why that's an issue:

> git reset --hard 474f7825d5335798742b92f067e1d22365013107
HEAD is now at 474f7825d533 fs: add copy_mount_setattr() helper

> git revert --no-edit 474f7825d5335798742b92f067e1d22365013107
[work.bisect e5673958d85c] Revert "fs: add copy_mount_setattr() helper"
 Date: Tue Apr 8 11:14:31 2025 +0200
 1 file changed, 33 insertions(+), 40 deletions(-)

