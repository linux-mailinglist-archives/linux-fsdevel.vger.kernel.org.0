Return-Path: <linux-fsdevel+bounces-36111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B75D9DBD50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 22:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24A4B21AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2021C4609;
	Thu, 28 Nov 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="V0lZpUJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0813DDB5;
	Thu, 28 Nov 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732829243; cv=none; b=RZDhOJD6S9jPWXX0QKrDJRug321f0M+7qPM0Ch/nqU5j87uXYBdRi5BO+WQ44WkEj4LZ4Lv9mFnPZA9A14y32552GShXjxRcokHj1y+/duoeesxRxGFJvpH7FwXXTNLLvvf8RsKVneS+Lv6BYEprAzVLNObFRfkIh5wbVu5gYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732829243; c=relaxed/simple;
	bh=v9EUsJLLHo79C3P0udTAyW7GKcHxmJaDGMV+Ji7hr3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gk+hlB3bpKDr1jJBuQxqNEQLSx+bA+5VpJa3PU2g7jaeGb7encbC6MAB6k4oiHOoTdrXzgmiz64y3sh1bHYRfnLa9FFzTpawNzJbcpRP0RHm5sawiE+UgYR6cEK5UnQOL09Jvc+hXiP7p5n0TpH8V+C0q/MBTejP9TA13XclnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=V0lZpUJO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732829219; x=1733434019; i=quwenruo.btrfs@gmx.com;
	bh=nmSVBXpOWNLnKUfu7fBmIxvhQ3j+xy+RWf9h1Hlt+dY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V0lZpUJOUcDM+p7oHCyWmzdRBclXOAqo4Xhcey+4CGP10HnQwNLGb4+d7+rT1Ppa
	 2yhP62K3JBr1MghjpRcG5S6NGTXck1G5TmHNJ21KZ4yQRvH9Bs2gUQT31bJQr2txF
	 Alpx2O87z6qWR2dVPBNLq6NcnF3o+jCnCz2SKuKB2ZxkKWzSJf8x4V5JPqS16ynDn
	 9VR9QSMLRFtHybfjzfcAzCMvTWf7gdVjWBe4xHHiDc45nZ9w+Zaae8R+7X0MYaqeR
	 aANasvLuC7gKPqhP8r5TcqhlSQWhS/UhuY1zCUbyxYXLKbkAseDJW5lUutnFLL/2r
	 iwWbXfe0g9MAWP0G1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNtF-1txmxD3lKn-00Zqdu; Thu, 28
 Nov 2024 22:26:59 +0100
Message-ID: <c6f218dc-60f2-47c5-b1ae-b84abbdfd2be@gmx.com>
Date: Fri, 29 Nov 2024 07:56:52 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nogikh@google.com, syzkaller-bugs@googlegroups.com,
 willy@infradead.org, wqu@suse.com
References: <6748bcc3.050a0220.253251.008c.GAE@google.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <6748bcc3.050a0220.253251.008c.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9tG/jfD+TLQPzLWdMpcNXJxJsQrE8D1mzhoW9oE2auLTt6Z9XaI
 c9jmUSnQeAFfWYHi45LeZeuRojYtCwxIsfbpbjfcffT+xTgyRuX1YwVXwZrzZoI+ga/9X7g
 k7I6hbI/4cmYw7BFnISy4nQ/17O3EcSKh2A8NQ6J01RNYgqkYNgcfS+oMI8LiSS/OvetjAO
 0IDzkWn1guWnLMGrIOzNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JJMo9rPL0pM=;DfO4/CedskYDXEBExa5mwG8H+DA
 QlXY+Vg49EtjvGaFms2HGIv3cpE6vIu8igtxRQGzZNtdMMAD/P2/IXh/J85KD7Bq2GKET10Ob
 Zbw8PQBrmnt/JYmlxiZJkOLmF3KIl586ReA9CmtKjNxmgljniyde4546UwjSizGK3K11EaO/A
 N/eQD0Vo6/uRp9sEu9qXqVuRPT4/TWxAR+wpeqojGP8z848x2nbH9m+CB82CRpS5NYs5WeO+v
 aPOtCk1EpY4h4s2Jjf3GEz5sSGM5FpGQnVduq0b6/PDvG5l6Svyn4aLgZ6UGd6JOyAa0iXcJM
 BJqWWu23cy4+E61d3pnAlSFt8BTSHbQV40rOD/axMl0GNaP8w7Wc64FiRupoqWUK+yDao/mAE
 mwxzkLykMUUyT4fw1ysVmtPWaAkXM9NNJ12EXL8ihmnJC3I4DbOdEdVAxCUhbNHs861b1zhZP
 doh+cJY2PXkDaWKPEhPm9lXn0HuH2UhqZboktV6Rc3VHT3VtXvfUFkiukL+B7hBxLpnu/Of/Q
 yBrd3kNjptsbchCqiwDRjTliNDH6+OfVECNojLNtSUB+Hdp3t3JpcbHwv66jBekax9ATJgMtV
 KdCl08sthq64I/TkuCv7wHHmGjfopNfi8++u4ipihNjiolBxmmNcU9150JJy+TziE4po3Tzo4
 18iwRMBkbMAQMz8/B6qq4Dx0ntgQfmlSSiOF9B5m5fxNcasaanVxoK3ASpGUQQcj+M1Gi2Hxn
 ivtstQz1Xgyns/Oef5ubAAaXYbQ6SvDVb03O73hS7okshqZenkZW2uN/bL1us8BQ/pyYkTIqI
 svg2RFadOhNa4/K7SYJVr2tDSBiAjQMoD+SBWEQIhFj0ATpEbmPasN/71EgJTMgPDawyqhs5N
 TseEB6aetl1BN+Z6eD1prQA8cd1QwN0cZQpeGobYNEHFErk9uVA0bil8mfuGOW73XFN1tBe6I
 R4x9sAowmCNLpj86IqoVYNDVtIw/s9jdC47gHkvkxBtygAQpBzjhPyYGFi4l3WJ8dDWren5Xs
 wstGnlkciqQfL3F+czW3dr4w+h2zLMj3pXE36mrBVF2p0+aaqtniNObSQ+fUNNi5KPBuJUS9L
 QyA9wBkONeZaWyT1P6fIUd4QWPcLEr

# syz test: https://github.com/adam900710/linux.git writeback_fix

=E5=9C=A8 2024/11/29 05:26, syzbot =E5=86=99=E9=81=93:
> syzbot has bisected this issue to:
>
> commit c87c299776e4d75bcc5559203ae2c37dc0396d80
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Thu Oct 10 04:46:12 2024 +0000
>
>      btrfs: make buffered write to copy one page a time
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D165dd3c05=
80000
> start commit:   228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes'=
 o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D155dd3c05=
80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D115dd3c05800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D402159daa216=
c89d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Daac7bff85be224=
de5156
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1384077858=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D178407785800=
00
>
> Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
> Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a time=
")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
>


