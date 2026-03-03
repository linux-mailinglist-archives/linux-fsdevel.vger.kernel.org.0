Return-Path: <linux-fsdevel+bounces-79291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MFtCQtjp2mghAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:39:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1921F8114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3855312E0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B8370D7D;
	Tue,  3 Mar 2026 22:38:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3435DA71
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577484; cv=none; b=NM5sUre+3C2i96rlB+dzya7sggu99MavAu0/LfyZB7q+ywrVzzGp+n/hed7gF9f6+bN8Kay9CK4NdhYTWzrUkKg0nNgBb1RDf1xW94lefTJF0G49mkRE6NkjhXTJRta937Ipbd8Ox2SaHDuJ+qXxYDuZRe4xuNPgbs8U8El1+PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577484; c=relaxed/simple;
	bh=+C9UCavQkoVwL+J+IJg1ofBcDjCKdUUSuXXXw7b0xHU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bGX7Ru146AmCok0q0nDgs9pdK2cq4mxR+shIXYC7RwvW+bgVpztg87AFGO6mEGOQO6gQTh03O7SBoca5aY+YCDEn2CjkUX4gVCcjmHntR8mKFsAqkUTxVgxA0LxYE4kjTRCffEdO3tJlHNW4I1e/chtzcdcZXNx6Ck5tAyoVTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d49709f87aso70789705a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 14:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772577482; x=1773182282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R7pc2WNAM1CjF+jiPOWSxHuDNZHMZhjC9JnQBKJnbw=;
        b=R8YrXCLl5MKTZA5DybGmgrmg1K0bLIfqYSMm0QTg4A+0DV12+LTNIjlMu0bGiZq4pm
         sHOvggtPW14/ZC7PNCPwGohn3FI3nHdlJ+w5op2i3lfL3hXhEMGu1DPtZvwkPmmXMfLQ
         mFo/vZy0+QYmKlx0gT2MShz8ixmZSWgg1cfLW1meBsUUsx+ilSJg2SCJ6h4SiswSangn
         ypojuqn3ZRZoJxwgp8fUXonK81l4wBh/N/JAQZp0sjctglWLwHc239LE/6kJjq4XO+d/
         Gbm5hNL9ichykI88Aa0j9lH2qELhpq2j3AhhfPn0W5cHfzc/L4oDtv0H9VAq7BDqrud8
         GF3w==
X-Forwarded-Encrypted: i=1; AJvYcCVuvjtz0m96b83/4lECf9kpp5GRn+/DFvJeHdObyMtIXoYb9feG3QEc4ae6qoFFUtJvvGlIh9LCJM9MWJ9l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33c/fVf8jgzUx2Y6gjd6q9ZGHkrw4wL3L+R0ny/PVXvVCvPKX
	D2IW2g+nW01DTU0mgvwf97uWx3chDBM49ib5KHMdxEgu/6f9S6ntj9ssxDTnR23X0JobMhTPJTe
	Xry6QHMr4w16EfoVAehoT761cAneiPecldBkWoVOd6F44zyx+9TS5+12wIV0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6acf:b0:676:aeb2:640 with SMTP id
 006d021491bc7-67b0ffa767amr92169eaf.4.1772577482416; Tue, 03 Mar 2026
 14:38:02 -0800 (PST)
Date: Tue, 03 Mar 2026 14:38:02 -0800
In-Reply-To: <CAJnrk1YQMZBHE+EhhDbxM9nAzCeBDkpr-w4128fSXVPNj03aPg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a762ca.a70a0220.b118c.0015.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: use-after-free Write in fuse_copy_do
From: syzbot <syzbot+23299dfcac137a96834a@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6A1921F8114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79291-lists,linux-fsdevel=lfdr.de,23299dfcac137a96834a];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,szeredi.hu,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.817];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c025f6cf Add linux-next specific files for 20260303
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b410fabe2a4318
dashboard link: https://syzkaller.appspot.com/bug?extid=23299dfcac137a96834a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1620f0ba580000


