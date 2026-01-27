Return-Path: <linux-fsdevel+bounces-75567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wARrArkreGl7oQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 04:06:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993E8F5ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5340C303814A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9982EB5D4;
	Tue, 27 Jan 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUlHtBda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC21C5D44
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483003; cv=none; b=EhAXA9QY7OduUAEIKYrWuIlE+PedYEtEFV3kauUawhXKGYuZJjffScls+FRv1H1nKDrvbEbLhtan7NvhzQtn0t+FtCccCBXAvewvPvNO0uWgv2PDOeEabMFPicovQgFeEOaCPMHbFveQoRfybq7DB8RW8bjwNgsGLdNFBqjKzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483003; c=relaxed/simple;
	bh=tWsEblAdFNsFjplzkBa4iKwTg5SxYymQHFqTCJuiOn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQP+d/IUnfE1m6G2+Ji5vjqJrEEcf2+zOEVwfgxv37lKltqj3hC7CL43sgKg2HCkuGOx0V1/tm+KR9GSGVadu8CYb+mlsvRuayBHTNHQpzBHjcW2GpBVWb5zGWwdhbthQ45F3sA5wcKbXqa5gz7bccb0Xov+bTqZiHqq/fxMxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUlHtBda; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124a1b4dd40so12736c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 19:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769483001; x=1770087801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x9VJw/Z7Ry7sj/KoXW90Dq2hOlgM6LNiTPF+BlLu6k=;
        b=bUlHtBdaFMe7mkfPgE+gz1vR+EmjoKVNrKpZINi+WLw/jJ1BpGSAbr1QjysFk8Iov5
         SiThA3GEEKFQRPW9ybnC0I+EhFG7rJe6WN1mcGSBvZVLBFbbdr2hPoCF/c6p0Eq/D4C8
         WaHWaxXFaE70crxNk5DrF0iLjiCKXb1Y4YHP8MZsq5pbhzaGcRQsEIEF3egoRoLDGO0W
         tZgTZkUhJOw1wmnbSljMkFSiYm/dW/44hFBi+fYuDPWvzTB1UY05E5yG7W3bbJdSPW6u
         WOTYkpvP9ehP4zKTX2dZA/tbVnfgyBKoFnd9RomPFEBPQHCzYN8IbnDjjW4jpSvX83Fh
         bOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769483001; x=1770087801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7x9VJw/Z7Ry7sj/KoXW90Dq2hOlgM6LNiTPF+BlLu6k=;
        b=h+6cf/3xQwGAesC32f76yaYLNXqhdkSvKvCAbAjJyBx0g2O8B6ZiNNl/GDKRF0Kkj4
         Z52wTgECOTJFHLinAdYNDMqPV1tr61Xq8e9fJ1AY9opyX4OPsadtZ6qbsBVFmKmAEEN6
         ZIFvwrNmnrfa2AiKhqFTm/LUJNmZuPjmZHEfwmPDuz6YTfE+CguB30x/Vpxg2dElyu5w
         748IZ3BoGJeAH2146AbYXiVFCytLWSW5FyRYfuoLUBVjy79uZet17U8ghwcnhjWloGYh
         4N4SEGZ66pZsbLwN4DAByfp30zyXPh3FbaQwEKnKJC6EwHCheyzkwT1749GFDpFDj+Nl
         BE6g==
X-Forwarded-Encrypted: i=1; AJvYcCWEcPtU0WmtRV42hdQVMJxqonH/0lqiytjgTfE/IeoQgo215wbOFBTCO5WbJjwFADUb8F2UVLLHDK7ChYLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGnv7PFV0bcR7QQFAjADUTbGlhPkBASNHZsmKFkcejIXOQo2y
	pgxnIVSUjtgAvTJpPuqoLyW3GTGqGZ6Tg/+7Q84uUUK1zB/qTqzNipw/
X-Gm-Gg: AZuq6aINOrAFPuG5oreeeKnpMLAFhZTBZLko4/ztK1voFMeLKTFuF+KmpCKP4hcYEq8
	e4Yj0bhOnw72r1jCqGrIfb4/s5iEJea2SRnwkAZmvOBWSi5dQOEyg4wejae77iz++1ePUg6lqib
	hAsgU5pdaYhisPf3F8R33a92NvFh1U1+aqWzH0RzZl65agEFaCxjqTFSNd/ICIN0Q3oab/tExNG
	GseGQW7tv/HqRWp5G1R5ON7HLLIc35HBVonB+ztcoidYGTdBOAsjKGC9BAu2u64rw/djZWNqD/F
	s46bfccBSL/B5a97bI8NKvkt30YL/joLKiXKsUJFzf/GoeBaHwnzfSMr37veMiSTQkW6n+mr4+g
	jC2HjueKC/p+Tp2JCanN0hFwjiFfk+8LX2i74sLrQ3cJbHxi2A2J8Cl7DlBaNWZ7nAHBS4bmjhp
	H4SVo=
X-Received: by 2002:a05:7301:6086:b0:2b7:3281:6c43 with SMTP id 5a478bee46e88-2b78d91deb1mr254498eec.15.1769483000722;
        Mon, 26 Jan 2026 19:03:20 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a691b1esm15834839eec.3.2026.01.26.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:03:20 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	realwujing@gmail.com,
	viro@zeniv.linux.org.uk,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v2] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
Date: Mon, 26 Jan 2026 22:03:02 -0500
Message-ID: <20260127030316.1189655-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123-wollust-vagabunden-af9d9bff4c4a@brauner>
References: <20260123-wollust-vagabunden-af9d9bff4c4a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75567-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,zeniv.linux.org.uk,chinatelecom.cn];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6993E8F5ED
X-Rspamd-Action: no action

Hi Christian,

Thanks for your feedback and for applying this patch to the vfs-7.0.misc branch!

On Fri, Jan 23, 2026 at 3:38 PM Christian Brauner <brauner@kernel.org> wrote:
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
>
> [1/1] fs/file: optimize close_range() complexity from O(N) to O(Sparse)
>       https://git.kernel.org/vfs/vfs/c/fc94368bcee5

I tried to locate the commit in vfs/vfs-7.0.misc (and also searched by subject),
but I couldn’t find it yet.

Subject:
fs/file: optimize close_range() complexity from O(N) to O(Sparse)

Is the patch still in your local queue / pending push, or did it land with a
different commit hash after a rebase?

Just wanted to double-check the current status.
Thanks again for the review and for taking the patch.

Best regards,
Qiliang

