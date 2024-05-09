Return-Path: <linux-fsdevel+bounces-19177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6835E8C108A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138C7285120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3E158DC5;
	Thu,  9 May 2024 13:42:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D49147C85;
	Thu,  9 May 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262160; cv=none; b=GBe/lG4SjVYIyYAUclwCOi6bxfBUs/mE6RoVozBYpgNtiLjyTgu+0GDMEdB441ogee7XhyrWUHW4SIDq6pGoHp0gVypDGpCEiljBb9xB6aCeUlsuCo44HM57gWrLLKQSk7YA64d5BVv3dGJgAAuNavp7CL3yVwhMM7TsFo/tTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262160; c=relaxed/simple;
	bh=3SzFTWiRHb3CLDtYFfiRADNKHA8TW0PS4sStlljhHKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjKv6Ja954of/tHKqV3YaAaDgAOI48nj37va17wvwolx/sIiNajSiU57uKXoDVUkm8/bj/Peca7i+3N5OijgUOv6s4/lABmmUgXS1flfA/llg4e+HujZn7l/Pzn743OCMJ7dnTZ07iUOB+1kAu8agLeHjKa+d9FGLrvwvVIIaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1s541X-0000000063q-16NF;
	Thu, 09 May 2024 09:41:27 -0400
Message-ID: <cfa4ec0f8f26ffceb6adcea96a182736519886ef.camel@surriel.com>
Subject: Re: [PATCH] fs/proc: fix softlockup in __read_vmcore
From: Rik van Riel <riel@surriel.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
Date: Thu, 09 May 2024 09:41:27 -0400
In-Reply-To: <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
References: <20240507091858.36ff767f@imladris.surriel.com>
	 <ZjxImBiQ+niK1PEw@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-05-09 at 11:52 +0800, Baoquan He wrote:
> Hi,
>=20
> On 05/07/24 at 09:18am, Rik van Riel wrote:
> > While taking a kernel core dump with makedumpfile on a larger
> > system,
> > softlockup messages often appear.
> >=20
> > While softlockup warnings can be harmless, they can also interfere
> > with things like RCU freeing memory, which can be problematic when
> > the kdump kexec image is configured with as little memory as
> > possible.
> >=20
> > Avoid the softlockup, and give things like work items and RCU a
> > chance to do their thing during __read_vmcore by adding a
> > cond_resched.
>=20
> Thanks for fixing this.
>=20
> By the way, is it easy to reproduce? And should we add some trace of
> the
> softlockup into log so that people can search for it and confirm when
> encountering it?

It is pretty easy to reproduce, but it does not happen all the time.
With millions of systems, even rare errors are common :)

However, we have been running with this fix for long enough (we
deployed it in order to test it) that I don't think we have the=C2=A0
warning stored any more. Those logs were rotated out long ago.

kind regards,

Rik
--=20
All Rights Reversed.

