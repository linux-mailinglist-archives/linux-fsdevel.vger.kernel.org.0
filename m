Return-Path: <linux-fsdevel+bounces-38629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A13A051E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D914F188893C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331B19F42D;
	Wed,  8 Jan 2025 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="hqMhgUTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636519993B;
	Wed,  8 Jan 2025 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736309385; cv=none; b=OSr0saNDHewFFmRX4VWpQ++CjvBko0qVBS/kQuis220pSGh6YDX42yFL0RTgiIQZ6seWoNTM4mZl9RqWxQ59yyf5UE6Z4NkB1KCXqwtkXtFkUuzDxP2dgPYNEWsQ46s1MFP15BPu5ykZFiphtwLZay4f0NTmZXY8fN/VFNOPKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736309385; c=relaxed/simple;
	bh=HYBB9nOGTmZcSXpiGzgQwpuPAuMzLNqn3Ot0wCXft6M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PWlNZQ1qlaJBDT4LoP6pds4coww+1hpVIDpIkzqwxFI3FwJgAAmeAZSfh0Q9ORDTem291HRkiDgYZUb4rMVnls2ZvqA1cjk+31S9JfiAoiPnXXtvYpwHswyEZnG9rKxoq2N+xoHhOvIOH8d0/CBTXHfUA7/7B/E88bw1IITo6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=hqMhgUTa; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736309354;
	bh=HYBB9nOGTmZcSXpiGzgQwpuPAuMzLNqn3Ot0wCXft6M=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=hqMhgUTaKWIcLI0MeFpe066aUwVg4X4HMCNIYCELjGF9RnztogXmZgCN2f+lr0lk2
	 n0Rw9BsBzFWqT5qvDqxZdLgJoNWF5Qd37XgMID8+00+xgHsTe70UOonKt+df+Kna4l
	 YnwC2V+5x+IDt+uLKLhiGZRCsD9Hcw3HEdpSQvXo=
X-QQ-mid: bizesmtpsz8t1736309348tw4ik38
X-QQ-Originating-IP: Q9/sq5glpDngX/efrYQwDVWZZb2QfcTFjEPDhGOwjCc=
Received: from smtpclient.apple ( [202.120.235.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Jan 2025 12:09:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5263847953183192212
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
Date: Wed, 8 Jan 2025 12:08:56 +0800
Cc: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
To: Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N/NyAQoofhIlejaJSB/zFDDrz8h/LrybDjocF7MOQ/jfNZa2jT9wxDz6
	amVuFetrEYMyVhVcTibbNhTMihj0oYt+A07IONP3vNN5ol1xSiszth57XpX5HKpSSwx2PWx
	Wxyv1nuUUphcrSy5iCA8Yr7BvsZr2Y6tYC6kRN8im4JPaP4O5BdE0tovTXAjw9WpsmtXMqA
	XBrIOPs9VQNjfiqYHDHaVjnNMk79zFM80W+/by77w1qLxaIrBVcxSu5872W/CtM5Pe7W/h0
	SpW+X3tEukX1KNdBTF7Pt536L72aJrIWA+Slcs2C33lpkr6EztNEPTPlTF5pHZQoIIPbfS3
	nIeO+NdQykuH4jglAueXXmnHHVeCpf+41iIUD0iegi53MBMVoFS06jq3+ulrGhuooodYKJq
	gX6XgXkZTEJSTRDQ7y2yVtkKBqoHkGeZCUjAEMD5vsWYWRLdE5c5FzMrOvwkBTXCfGurnSM
	TF96IqhjELyCPSP/KxgHEHglP0BJkkay/UNGH/rNYRVkla6CFahUaUF3BRLByjng0DYGyhG
	f7oqIyRVLaSxCJDcxwEj0R08ZcbE559/Q7cwdJ4Pq0evXKWIuqbv63xmIwivGgm4m6GWZ18
	TpvXkMsB7wOi5+P+SdVTtagqr6CHEp9RUVwe4iy5UeOlJREjsImSyxsuE5QJTVBCwKlcV6L
	zTfsw46KH6benh/Y0Qwq/eo3OS3mjwjHUgn+Xsb/6WXv73ZZrzty4bH8eFb061dXRCFB/8K
	SvaUqQuGK4wbZW4lfGgfley9VhdSYTbZYCJsTJGwkPd+VrZQADqyMUyVUvUmh1D6xd5NEzR
	ZlMiC+prvRhmmsD0opC9VWrvCm3x8Mzduh1tP5/wpZlXE0qQlUEe0XRyRTp5MNoM57ZZvmK
	FiyV3xAq9b3IxQU29Y6J/TK35z7DwJZeWbR398/jFVzYWpsNyEhgsb5hTpJLTETi8bMNwpy
	TY4jGj9QEpvNSKqaF6BbfVI5N
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


>>=20
>> HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
>> git tree: upstream
>> Console output: =
https://drive.google.com/file/d/1-YGytaKuh9M4hI6x27YjsE0vSyRFngf5/view?usp=
=3Dsharing
>> Kernel config: =
https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=
=3Dsharing
>> C reproducer: /
>> Syzlang reproducer: /
>>=20
>> We found an issue in the __bh_read function at line 3086, where a
>> slab-out-of-bounds error was reported. While the BUG_ON check ensures
>> that bh is locked, I suspect it=E2=80=99s possible that bh might have =
been
>> released prior to the call to __bh_read. This could result in =
accessing
>> invalid memory, ultimately triggering the reported issue.
>=20
> Well, most likely the bh pointer has already been corrupted. Again, =
nobody
> is likely to be able to debug this unless we have a reliable way to
> reproduce this problem.


Hi, Jan.

We have obtained the reproducers of this issue for multi round testing. =
But, the crash location seems to vary. The crash log shows a possible =
deadlock occurring in =E2=80=9Cgfs2_trans_begin" in /fs/gfs2/trans.c, =
with duplicate registrations happening when attempting to register a =
"kobject."

The links of these related files are at below:

Log: =
https://drive.google.com/file/d/1MaRMA6WKz4e7fuDw-Yrb-Zw6GhXSIFsr/view?usp=
=3Dsharing
C repro: =
https://drive.google.com/file/d/1VdDFjW2XNDhxe9yjb01qLblDxJpQyxzh/view?usp=
=3Dsharing
Syz repro: =
https://drive.google.com/file/d/1sLGQnJb2-DCA6EsLia8SyOte0zKnlbF7/view?usp=
=3Dsharing

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu=

