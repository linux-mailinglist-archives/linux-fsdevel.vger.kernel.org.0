Return-Path: <linux-fsdevel+bounces-21752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77A909677
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 09:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62D1C2193E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996B17557;
	Sat, 15 Jun 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DIpnbk5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB44A1E;
	Sat, 15 Jun 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435298; cv=none; b=dCntOlCzPdS4S/gr8NRwAfNSbcaSJ1h1tSk+8NAn7X0TyZ2K1Nw8jjMMpVVgqUAmTnIKbQnPf5ys3Ok8KT6BcOvyRSfLCtGkNNEg0t/9FQF9XwHxFN3YWVfo585XaKxINyHXh7QM+U76tyyBli0BgBmQjJ1O0ZL6Tn6q9Hf+kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435298; c=relaxed/simple;
	bh=ZwcvdUxc1M3aHoVk5X4ehy4eeQBGFf7+nPhJ9DpI80I=;
	h=In-Reply-To:References:From:To:Cc:Subject:Mime-Version:
	 Content-Type:Date:Message-ID; b=fSxwHHSniqbn3QKxKrae/gHOg1XssrZ5S8WuAt+2IW6AmE0Om8adfmMmKXCCs7NMSVplgvYVS2RAqvk8uxG3GR1umhXO8UVTZ+cWXlx+/do/prbXZVhpME0QugBo1wGZg+WknIvym7P6v2qswEC63oVKUSV0/BMnig57ITt8xq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DIpnbk5j; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718434983; bh=ZwcvdUxc1M3aHoVk5X4ehy4eeQBGFf7+nPhJ9DpI80I=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date;
	b=DIpnbk5jJoumBOggwKKPf/FBL1DTCHlsTCCS7L8udcZpzhfj84WcUCZM4P9DOeEdM
	 +fylqSruoeepJfm77Du7euA5eByfcqc9GN6cjZ+ISWhvW1AoPWtKtGf/dVntJRlph3
	 i/wRPlQKX3Irc20CwF2Af91eq/YlQlAzTX8jRzb4=
X-QQ-FEAT: +BBVktQ4OjZRGhAMCybSmgbXOah7CjTG
X-QQ-SSF: 0000000000000040000000000000
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-XMAILINFO: MKXYKvFqLnFrSEzRnk6j4uTDT+iE3Bkprc9glgWCzP882CopSjHdjMRGk6oyVP
	 xxLQbg3UZVf9/meqPwbrj8S1Rnc4cMeaQxhOIPB/Qc/yQ4puq+ZHJ3MiiO5UaM9j2bDYqw9lzcHTM
	 Z8BKe6GIzCBmgnsFmROgT/Qlansat5m4bDeVvVzX6QKY4ooP7u5bdkxnDy46GZESNeVoLISM4PaBu
	 iUjDUqa0c8hKHnc0vo9gC6mekc+4y7Hdlz1i9lppfzwbEgwY807RdaaBvwBMz/VVuxCO4vgw33Izw
	 0Bj7cTA3T1SVX4TDSQjoXZPbyRv7LdodPDZyQ+nzPwwLoFeKtEZDivcjld51/Tf7A/+YBQc9YK36G
	 J8+d6dor+ybwrjy3RsS4ZvKqhC72Fhs/52rnvOCDDYMIUb5q5G7rblDkbHj/kxwOCPDNs3pp8twn3
	 PBJFlQXH8p9IuDoLFI6TkqbR74/eE1RdcGLBEQrXXTe3M1lXB97o7QaPhMM6Dsiphsg/VHUbd2mga
	 N3+YDwgsPwFWAxuUv30bCfEjMICDXUhsAD5+7VyBwMzWvyxgjo2bKzckVC9mrlFA9GZpRai8p8Scu
	 ZqEhTR9Yk4oti0QCQPbEe+SwaMQ70IgdyFn20+3NGBPjayTkQ+7X4ElleY0ZBrzJY2U8FV90tAK+6
	 SVPOs7dAkdeZP4QdCaZf4t13Kif4dWual8UosAqQJD1MaSTPDPjrq/sKUazT1r98gNTnSB21uLXBA
	 xEC2mrSvrlCBAfLUYIYwKHwDfUKzUzUGOIaAMZX+2WwjlnbXdDE8COK2g2lhA1br5jYEXqQike4JR
	 8todALKt2dAMhg0cXTw3UgApOEtWLBGQgIr/u/0T9MbEhZDonOpkCuJJCzHEyjNrNfaz7tN1e479r
	 n1qGn44hFFfbSVxeT0ZHKt9193CH1oiQVSEo6qRMhpTakFqIpxriPvAgOcXCLVDDPMIrjy9dqN2HC
	 vUZBGpKgVRbRfEchM2
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
In-Reply-To: <Zm000qL0N6XY7-4O@infradead.org>
References: <20240615030056.GO1629371@ZenIV>
 <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
	<Zm000qL0N6XY7-4O@infradead.org>
X-QQ-STYLE: 
X-QQ-mid: webmail648t1718434181t8448596
From: "=?ISO-8859-1?B?emNqaWUwODAy?=" <zcjie0802@qq.com>
To: "=?ISO-8859-1?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@infradead.org>
Cc: "=?ISO-8859-1?B?dmlybw==?=" <viro@zeniv.linux.org.uk>, "=?ISO-8859-1?B?YnJhdW5lcg==?=" <brauner@kernel.org>, "=?ISO-8859-1?B?bGludXgtZnNkZXZlbA==?=" <linux-fsdevel@vger.kernel.org>, "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Sat, 15 Jun 2024 14:49:41 +0800
X-Priority: 3
Message-ID: <tencent_5A1C3E3D91192539DE8138D4A6DC72EBD107@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

VGhlIEBkZW50cnkgaXMgYWN0dWFsbHkgdGhlIGRlbnRyeSBvZiBjaGlsZCBkaXJlY3Rvcnks
IGJ1dCB0aGUgb3JpZ2luIGFubm90YXRpb24gaW5kaWNhdGVzIGl0IGlzIGRlbnRyeSBvZiBw
YXJlbnQgZGlyZWN0b3J5LgpUaGUgQGRpciBpcyBzaW1pbGFyLg==


