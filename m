Return-Path: <linux-fsdevel+bounces-59340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D612EB379E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 07:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925C37C6114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB303101B1;
	Wed, 27 Aug 2025 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b="cOJOcbXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34C30E855;
	Wed, 27 Aug 2025 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272780; cv=none; b=JYAN02MYyX23DL+rVUrSU2jMynfAIjwgPV8h/6Sk+YZujcrqp3a6PbQVliSDX5WAufxwjXz3ZTek5OMkg2QjWhiDVeyIQXUAheIAzwr6VK+6sOVekpq8F/2r9XN/67LHaB46QEPjiqP3voSLKKTEI0b/G1SJDEjPdylpMySTg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272780; c=relaxed/simple;
	bh=84LVWU4cpEOLxd0MXw2tC84Lgj/ODwkRX+iuySfFOGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ3NUbE6RgS9NCrfap6Z8RBmx/lxySk08Kowv+31KIEbnaPfMt0Z1o4giwShKHq+7cJTjaF2qjnaJ295Gn+NjHqBdzs85DDIk0mIPCtvXMYOQY0E8zGIvo9hKMyx0js32+NVVEmh05LxkXbGqcsrQ3qihZk1peCRBiV7KQC6KBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b=cOJOcbXu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756272751; x=1756877551; i=polynomial-c@gmx.de;
	bh=84LVWU4cpEOLxd0MXw2tC84Lgj/ODwkRX+iuySfFOGE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cOJOcbXuK0fr9nRCtH3S7ORSCBDB0UOoHCdOr2y5T82ACk6GRHtWVtCwW2NWHp5t
	 Ilg+6XjBhT7R9tLXEPPlQTH2C58QQpnM225IlEUEh0iJ5tdK2jnGWmMieEp736V6f
	 FS3mev8MQQ8VII5du719JgZPFwFoTcMDcpFVf391TaABUG6h+KGsDDxlJu2bkfg+y
	 1Sh87XPdrnOvL8Olk0bHaCmnWMeBvuKLXc7WPT2FhgwQUXthAZjhsoRhtOpTc971P
	 zoCFukT5z/7zwnwFojPFwEXLl7e+Au/d0LNVkuEjBxQQK6DG8vP73tvM13oMY44dH
	 PhMOXmJ1KqLZ3w0XMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from chagall.paradoxon.rec ([79.234.222.21]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M26r3-1upCxa27rd-00HNMm; Wed, 27 Aug 2025 07:32:31 +0200
Date: Wed, 27 Aug 2025 07:32:28 +0200
From: Lars Wendler <polynomial-c@gmx.de>
To: Petr =?UTF-8?B?VmFuxJtr?= <pv@excello.cz>
Cc: wangzijie <wangzijie1@honor.com>, akpm@linux-foundation.org,
 brauner@kernel.org, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
 rick.p.edgecombe@intel.com, ast@kernel.org, k.shutemov@gmail.com,
 jirislaby@kernel.org, linux-fsdevel@vger.kernel.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Message-ID: <20250827073228.0fb7be05@chagall.paradoxon.rec>
In-Reply-To: <20258249055-aKrUxz36A3Yw6qDd-pv@excello.cz>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
	<20258249055-aKrUxz36A3Yw6qDd-pv@excello.cz>
Organization: privat
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aEaOPrZ06QX15tiv/TUPv5tE4O6b2kpbL3ZBN3cswoGvBpmzSv7
 hcoNyftRPLNa4/4oUAjdsN8BTSPP7zlgg7kxpl6D54J4kivlOb0ewgbdEg0+hHw75eM0HaX
 RKXuTuWRf9WDSmlxQo3rhZxagnQas/xAKp3Qamwj7KqV+XJXRJSW4xppVoYPFfGurWBPfvg
 WEefmsugiEgaXsg2Yf/yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sPOKET8lcnU=;4lXMB7h4ZRwI5FoqgvPTApjs5zI
 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
 HFmPVoAQiM

Am Sun, 24 Aug 2025 11:00:55 +0200
schrieb Petr Van=C4=9Bk <pv@excello.cz>:

> On Thu, Aug 21, 2025 at 06:58:06PM +0800, wangzijie wrote:
> > To avoid potential UAF issues during module removal races, we use
> > pde_set_flags() to save proc_ops flags in PDE itself before
> > proc_register(), and then use pde_has_proc_*() helpers instead of
> > directly dereferencing pde->proc_ops->*.
> >=20
> > However, the pde_set_flags() call was missing when creating net
> > related proc files. This omission caused incorrect behavior which
> > FMODE_LSEEK was being cleared inappropriately in proc_reg_open()
> > for net proc files. Lars reported it in this link[1].
> >=20
> > Fix this by ensuring pde_set_flags() is called when register proc
> > entry, and add NULL check for proc_ops in pde_set_flags().
> >=20
> > [1]:
> > https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.r=
ec/
> >=20
> > Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check
> > proc_lseek as ones for proc_read_iter et.al") Cc:
> > stable@vger.kernel.org Reported-by: Lars Wendler
> > <polynomial-c@gmx.de> Signed-off-by: wangzijie
> > <wangzijie1@honor.com>
>=20
> Tested-by: Petr Van=C4=9Bk <pv@excello.cz>
>=20
> We have noticed lseek issue with /proc/self/net/sockstat file recently
> and this patch fixes it for us.
>=20
> Thanks,
> Petr

Applied to linux-6.12.43 and it fixes the issue in linux-6.12.y branch.
I have yet to test it in linux-6.6.y branch.

Tested by: Lars Wendler <polynomial-c@gmx.de>

Thanks
Lars

