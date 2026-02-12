Return-Path: <linux-fsdevel+bounces-76998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOGhKo2YjWkt5AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:08:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5C12BBEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26FC9303B4DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237FB2DC763;
	Thu, 12 Feb 2026 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XrA/5PCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DF2D6E78
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887292; cv=pass; b=Y/pZDxLhGP74V9N8NAxjZFJl+oal4HtUHe6gb3ZdUZ2Y6lJfAm0Pf3Mbr6LuvxjHIOV78NkgXlxJ2OS2AfoGuLt/qF6llVIeXppJhEyCCkiA+G6H9ri0CBMJ8eWee7kfgzO50d1Arr5DIuMjyqriS2FlU/vscKx2Z77BhkOk97E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887292; c=relaxed/simple;
	bh=A3YC6Fd6KicFgkJegqz2B9jkg4YN6euwv44OX/9ecgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grHFaGwvNwje5zG9KBAVmweUL6z3fiurHSQVnGfw0e//ck/q3O/tzdGonJ+6L0z3Ifuckv5F3bEBfXenZDglB9vSe/Jn/LTS553bTABwnMy4HZIDx2VIwomMHH0da6ZWnMXjhplK4XrOpX9I+LZP/goi3uH9yPoICa4szysAK6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XrA/5PCj; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502a26e8711so17090971cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 01:08:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770887289; cv=none;
        d=google.com; s=arc-20240605;
        b=SMyDRpJEQz7JPJ4P4D76wNTFnSrrfZvdqnG49RUn6GN9g1UYgXTXxIr4BC4dVmKbm5
         ZYt+C39JVH2Lc7dnxqms8wORpKwzZqndYxmq08Z4xap7/5wHlNYCg75CBauJQbxt76N5
         /X77ibnyDMHsGjrvTljg0Zx20ylvsvaPmES4kocjFI3IntTfOGYm8XEKrY6ULobURbRk
         OLJ2p6aEo+lcbSUtVSJOtv2x6XPQLA0OtDsNQ0S8XWM4M1uffzzkYVhYcNWbQx4sfv/p
         RlQkJp6wqVLNhzaa4XfX0fuTaSdgoGpdyVsK7ZFTobdl9ld74mjrnhA5YHQFNTj8LqaA
         SmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=efrXB96azW/NBa2yMq1sjjjrjo1waTX5GxnBBx3HoiM=;
        fh=aDMddJC+uSWq7gjaqUJHhFs3s3nI4kTBiL1uh8M9ooY=;
        b=JxdLT3+UfsONWF8OJCJf2o10X28/RCaDI0nCM4zgTiXVLutkbgpZt19keKcEeIyHim
         543VnkfXlNVjfD/nFKexWBVWrihLwp7lQrZn+ExmyJrfgO0hDkwalPx3dHFZIXqo9U+r
         EmnbGAIwuRyvw0njHuM6I2NXu2efdb7s11VVz6bdr3fVkUbWuijPWSiKtkWKdTBqKMij
         ljKRSQTMWmjy6agl1g363YMWcOdZ/37Em9pQHm2AoSAPKqKtgOexcGzxnRYRvQ7Kv5Xo
         0mZ666BAZUZ01SYrDo+B1vLPNacs4JJp4r2+BUdCOIp0qPmX9xfifhmTreXDowu17Bsj
         vaog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770887289; x=1771492089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=efrXB96azW/NBa2yMq1sjjjrjo1waTX5GxnBBx3HoiM=;
        b=XrA/5PCjNznUHYoa6LYOOEAr1OgB6hE4y+m1DddaJhFi8rCj8eSRuTeKQLyW/ztr+p
         5UCrsqe2ehBG6xFBHN4PDTg8L8UkbOzgUwQ3RUpikVwtE3vZSfvKAiRuV8ARQgtG5MLL
         aRAzN+V+aRyor+c/KRtdz3YbQW+Kl9pJYTxc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770887289; x=1771492089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efrXB96azW/NBa2yMq1sjjjrjo1waTX5GxnBBx3HoiM=;
        b=S/koi/BfnNIg13Ve6DYRHAzhxH6L/zHBRDYwkdMm/b82SDRSeeMZdrpuEYAwW6EGWx
         sxNP8eJXQRJiHu7mxYgZ03i1tVPEqri8xmFNZy1PuvWhyxYfI2NcgxlWjLsBXP16sn/Q
         BwMlv7lh4haDm2sm/t6LLOOpMOCW+AHGglJkGrJTeq+paS/HNb2BSaOKws0nrM37/kn1
         gwDDiBaZZJXZwE7K4+j/rey26rhZ9OkKaHFPFwMzP9v/O8yXzbuHqgsGXq8yZ3JEQurW
         wdXpe3bfZs1AWddAFrHloQprC6tBEujxoNL2U3BtDigohsO708q667jP7ZIv5TZ2Gqh2
         DBdA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Qd+tTZqmt0u0y9oamekJM4IwnucPR6gLJvWbwAK6BSWLAoauzoT0LMQ9h7f10l0pZp86HaBGSN5EZ37f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PsUFB2rUg4diwuRH4Qf3GShVODiLVIxyhIl0t2wdHndnCZq2
	uleYoQRSW63Pt4siAv24eI6Cl9wchUF4fJjJirzpfdVf5mjp0mNXv3aWjTKG9qtt7QvW0HRDKI0
	X60bsq5cLUxTEXochHiwMzLBB72tCoM2G4ZUYkafHjg==
X-Gm-Gg: AZuq6aIuwutp5jEJQJ1DsD16QMIwdZuvov35RjwoxdwJl688AMqWXm8x74wyFTuYvTJ
	Ai+jefojXDQf1b3W2Pt/VUkYT/RGN+uXGb/kwov0xWL0RrpUfw4qJakPRzMZ8Fx6bcXbWI+t0V7
	Pd5TSGMjWBNzGSsA2DOyFYMqvNgok6qaS1XxdrnvJ0EOkbeheLwCzori5/eyGakDgOTmwVpN1Dt
	LCF/lQFgwp62gXWBDN4eyNZWGjNMnrVKCn9lJaX/wsQ1Lxyk/PQRHTnE6XCx3CYP/QH2Abtu0xL
	QlBjFw==
X-Received: by 2002:ac8:6145:0:10b0:4f0:21f2:cc98 with SMTP id
 d75a77b69052e-50694ba42bamr11035561cf.50.1770887289173; Thu, 12 Feb 2026
 01:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com> <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
In-Reply-To: <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 10:07:57 +0100
X-Gm-Features: AZwV_Qht6TWKNhZD4s997ExxjNsYmxGeOSmd3oUlqnEeo2mrYQffHeDqeaQAr6o
Message-ID: <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76998-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim,bsbernd.com:email]
X-Rspamd-Queue-Id: 1EE5C12BBEE
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:

> With simple request and a single request per buffer, one can re-use the
> existing buffer for the reply in fuse-server
>
> - write: Do the write operation, then store the result into the io-buffer
> - read: Copy the relatively small header, store the result into the
> io-buffer
>
> - Meta-operations: Same as read

Reminds me of the header/payload separation in io-uring.

We could actually do that on the /dev/fuse interface as well, just
never got around to implementing it:  first page reserved for
header(s), payload is stored at PAGE_SIZE offset in the supplied
buffer.

That doesn't solve the overwriting problem, since in theory we could
have a compound with a READ and a WRITE but in practice we can just
disallow such combinations.

In fact I'd argue that most/all practical compounds will not even have
a payload and can fit into a page sized buffer.

So as a first iteration can we just limit compounds to small in/out sizes?

Thanks,
Miklos

