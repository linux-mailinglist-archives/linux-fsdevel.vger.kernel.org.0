Return-Path: <linux-fsdevel+bounces-77115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHmaHj/xjmk5GAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:39:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E7713493F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D963088743
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52434D929;
	Fri, 13 Feb 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgxbO7XL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCD34D915
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975533; cv=none; b=Mm8aXAeS6FG0kFHrT0ryNLoAHw7u8wjXrLy5I6L9p5t8PQmcBOPzeUsOwkPlcTJE5uKL9B9fs+TqZSpv+TxAr0MtyVwO4/cN0QIlDtD1XxtSbn2fREvv6fIWNMJ0ldQ029uBgz72QJIIIar8Izjxoswa88jYzSDPuk0BMZ214tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975533; c=relaxed/simple;
	bh=qRk0XbgqqkHbS1K5VlJc19rLQpxSWv7j9+VNx/G3fnY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QT1CSEjBKPTUlMpIQv812ocZKrp6Lhe7dvE1TfmPnW/aRwN8Ww6+qdQCbT0X5PjYw06gk2Akp1PtvXQ/d7eWGOYBX/XzqaO0lfUHYtmwXbiqXjWB/TvnWuc1Mkuw/2LA7WW/kwsgwDr07xJRV75xjagD6fYqgcQZAHGB4sofuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgxbO7XL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824a829f9bbso450618b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 01:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770975531; x=1771580331; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r2feZNNUcf548IzTebf5d7uh7AISHSV/SqdlNPNXAQ=;
        b=AgxbO7XLrW/tCW+Tr5cP7eOdr2Wo6zcTY+c/qj7i3oS7IQH7HXab+MLdb1nPTWz0KO
         6+GPlxrXtjP3E73MphVvdZ55HDPkJX6dKaThVfp+schP2jqnLnGy2nZPdg3dFlln5f2k
         PE6In9XaVn7cZqqCtkEuD6CLQ66JcFTlj4Ti5bvO2bOoPA4OPW28/c8Rryj1qlBYJzpm
         TPtEWaOHqJVX+vGR7cCZMtQUFKe+e8mM0BUeo1lV7irHEPTOeLyTsFgETnFQBw7AzGIy
         LhMXOFqED7nPy+KNu0ZMAOEuZLL3d8e3+xB057IispbAzAx8DtaS7uxlf7YkX1/KpdwI
         Lz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770975531; x=1771580331;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r2feZNNUcf548IzTebf5d7uh7AISHSV/SqdlNPNXAQ=;
        b=HKDKoeE3uZb/oUL/lL26NSgay9O12fycLMVJvkzbFB/z8aBQcAt4DVcPekg6kHYPtW
         t16QWASnjJlOH8XSXRMbGZZ/VF8MD649/saqmGQvtF1smg8l1eGU1rNyp1s2oIgCKwvR
         syPAIkJ4y/8U9lzukmv++uWrPGkIdezdqTMj92FR5nDWgrfAvTZfdEvjvT0JuOBoItpY
         1zw/OR4a7ri6nVq/omtfsS9G9URxI2WRO3zZE208eecnHuGvhJGObQD51+HmKd8FszIC
         MUfNorPMMxA3TCvK+UXbHJ9aVbT0K1P43KhUfU6h+qwLjT3h6gzYwJ2FKU2mqIBCeMnZ
         aadQ==
X-Gm-Message-State: AOJu0YxgHb44VHdOKxhfH15YSw38gaHc0B65pbUMFS5v8k7Mj8eoBbhz
	uQCG3DOLD7pXIsWuKmaU1zett0Lxdg/LsLtvEMGsPCR/G32RLAfoqlBu
X-Gm-Gg: AZuq6aKWAKI8QL+6ch0IYN91GNwLcrCk/Yw7tEwDzR5TCeRRLe/rIf7u9NfTaIbTgii
	jeJuBl+K8y8zamf6G8UNM7Rtev/BtglLyXbauCu9JtlQLc+8hDGYDFrZRPOun7PnN1WTHg04CJW
	V6DvfEY2GYsK1/+ffJIQxYhbk66kWnyNEAD+2kI9GVS2YxGo2WWR96pCx1IN5ds8rjk8ziocEoE
	DUEw57f5qhrwJT8mo/XnwcZXa5jRhph6RZeBbVwqQioZPirwSw98+ZUZvwz2LZRZDYYUGlr7DwV
	/woXeHLbTapMmGEIxRSy5s37c3ej0kBGuaxva8q6zQ5A6iO6ezcIvzWAz00RgIK0s65K5RimmlF
	72OUQI7LIXE17nyfB18F/D+tiXRt8kMhdQvVIruuDTH1uVo7uoEEZ6JsZ+fyr/CEBtvRNcvFoYY
	vuQaTtqnOSe4JCFhu++UdzqrrCGLBHfjeZRNY7VNYrEd898c+hiPllQT+qOFQ=
X-Received: by 2002:a05:6a21:918b:b0:38e:883f:694d with SMTP id adf61e73a8af0-3946c79cfdamr1391165637.24.1770975531048;
        Fri, 13 Feb 2026 01:38:51 -0800 (PST)
Received: from localhost ([2405:201:3017:184:52f5:ed80:f874:1efc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e196a8eb2sm7095318a12.11.2026.02.13.01.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 01:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 15:08:44 +0530
Message-Id: <DGDQFGJLPLU0.19QNB0MQLITQO@gmail.com>
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Qing Wang" <wangqing7171@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Bhavik Sachdev" <b.sachdev1904@gmail.com>, "Andrei Vagin"
 <avagin@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com>
Subject: Re: [PATCH] statmount: Fix the null-ptr-deref in do_statmount()
X-Mailer: aerc 0.21.0
References: <20260213084259.2423971-1-wangqing7171@gmail.com>
In-Reply-To: <20260213084259.2423971-1-wangqing7171@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77115-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bsachdev1904@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4E7713493F
X-Rspamd-Action: no action

On Fri Feb 13, 2026 at 2:12 PM IST, Qing Wang wrote:
> If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
> defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
> of mount by IS_ERR_OR_NULL().
>
> Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
> Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@goo=
gle.com/
> Tested-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  fs/namespace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a67cbe42746d..d769d50de5d6 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5678,13 +5678,15 @@ static int do_statmount(struct kstatmount *s, u64=
 mnt_id, u64 mnt_ns_id,
> =20
>  		s->mnt =3D mnt_file->f_path.mnt;
>  		ns =3D real_mount(s->mnt)->mnt_ns;
> -		if (!ns)
> +		if (IS_ERR_OR_NULL(ns)) {
>  			/*
>  			 * We can't set mount point and mnt_ns_id since we don't have a
>  			 * ns for the mount. This can happen if the mount is unmounted
> -			 * with MNT_DETACH.
> +			 * with MNT_DETACH or if it's an internal mount.
>  			 */
>  			s->mask &=3D ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
> +			ns =3D NULL;
> +		}
>  	} else {
>  		/* Has the namespace already been emptied? */
>  		if (mnt_ns_id && mnt_ns_empty(ns))
Hey!
I think the fix should be the following instead, AFAIU we don't want a
call to an internal mount to succeed.

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..55152bf64785 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,6 +5678,8 @@ static int do_statmount(struct kstatmount *s, u64 mnt=
_id, u64 mnt_ns_id,

                s->mnt =3D mnt_file->f_path.mnt;
                ns =3D real_mount(s->mnt)->mnt_ns;
+               if (IS_ERR(ns))
+                       return -EINVAL;
                if (!ns)
                        /*
                         * We can't set mount point and mnt_ns_id since we =
don't have a

Thanks,
Bhavik

