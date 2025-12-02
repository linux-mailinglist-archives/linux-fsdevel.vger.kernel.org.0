Return-Path: <linux-fsdevel+bounces-70486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FAC9D371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9E7934A07F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549242F9DAB;
	Tue,  2 Dec 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgUakz7S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDHjK4ks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA3A2EB5A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714660; cv=none; b=mkitesKih9of/QQoAxwkTILOHJQDom4eNCLGhmGu/7vcJT/4sfI1Z1moa1zI7AGHcZ1czi8c9h08VLhG3u4aWdD9Ls5ENqivtlG9hTOpOHzzsGUT4Z25UGgxPCdY30VdzGdGv/gh/TQbcn5fAajUsAlrux9QPfCqehHP+HH1c3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714660; c=relaxed/simple;
	bh=MmUh4MKXgs1k08VeXFr5wg8d4AsDjxUObXE1+1XdpG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayu1DTzCQIUzOvGFWOXJBQgxct86Sxvip1TXivjsNdbvERJ6gmsaJA+wHsZXtOuQKcthiJQiv24Lto+UO/FWDvWzrcBfL3uWZAYYlzEU9a3QCj2GSrcwdH8J08kHupy7EDaUq2Qijl1zkNl8MtwuZ4uJ31gVxMY4yc93FLzoKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgUakz7S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDHjK4ks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764714658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XpYvds7AGfom+0aJqkkhOOQLSOqoY1MbT24dcNg0Fo=;
	b=NgUakz7SpJBQsuHS6EmPDbwBi/DgFIDueCOQzii24HwIxrxyF732cI+lDRdrN7P7i0Ityf
	iG05rifkcYWUQ4VURgvmO/UdlEANipUe04pIfnfIp8nvyMWLhPZTRaKB+zTIzQm4XjzUqa
	C5UU6EtwMtWzPxAUMzrYHD8RvdABCsA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-nbUP_WRpMlOUCJLhchSF1g-1; Tue, 02 Dec 2025 17:30:55 -0500
X-MC-Unique: nbUP_WRpMlOUCJLhchSF1g-1
X-Mimecast-MFC-AGG-ID: nbUP_WRpMlOUCJLhchSF1g_1764714655
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-656bc3a7ab3so6125383eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764714655; x=1765319455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XpYvds7AGfom+0aJqkkhOOQLSOqoY1MbT24dcNg0Fo=;
        b=ZDHjK4ksZloI7M8wupk6J+XVjkx0vXOC4IH9UP65hMZH2LhkIFswI8qxBAwtA4BLNu
         JuofpZ0JxHgfoW83vz+b4DNxZBUtmmYxBZLV/RSClms3jGiW76TmNXE7pB22dygYYaJ8
         4RSosrS7bqy74mdrNf/SG0Cw96GKJ33aUYxR0NOuWr0mCYfyLKj2D6CkJlf7LC2GEAk9
         e5MVuI3gRYNowbTPizWyuJErmUWWzErX9b0aaUYlNpZgNg/PrVF1txYfw6Gmfv94HWun
         UZQ4GXw+MBnSyRE0YF82gFXNNb9NKl0PW7y5DLIpkQXpgWIaLEgP/EBRav6x35uKqHcu
         DzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714655; x=1765319455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XpYvds7AGfom+0aJqkkhOOQLSOqoY1MbT24dcNg0Fo=;
        b=HLL0XoeEdjwnOJZbDAdoKIeo4Y2qCmd+CntLvMAj6VXf+bB7rWQJJ2jaKEGNYpKVST
         U4YUr0aCSRkDgwMni6PyBnaCi6l2CUcYjRMDqCO4Qeq2O9fgP6OrlGSZ7i6YwdC+th8v
         7RJspVY8g4DksfR3d0bp5jo5LFczD+4BJSJZM4wYvU3mnW5jy4SIQBYUoPr5kMF7uhQo
         txQsJdRkTNSw37ab6+DO2bVhoYXFPMOmma0na+LrDeFFsrDirQXTg2n7ALjBrDM2WG4s
         CFKO1WFyPVzBPIgX+0S5Zu68DARSVWejbG+ayamtfQGLE5rj1IzO+6OH4JUqFlpvyPUI
         pRwg==
X-Gm-Message-State: AOJu0YywmouTjUOMt9aGFjc1vY4lPnLYlMiV5iRhAdXJmlmH2kCOehu0
	N/0FTQ099jhd2eAXiieMxg5deO/boY7cHfjj7pSFEJU3OKNI1DldjZzwzJBmdv39+xU6V48/4CV
	B5Urnkv4ZB/R/SaY3TNIacNw0wvnhl9q6F0RreVb8IxKi8frRttoneJsLso5YbAS/a+jLbdp7nc
	s39w==
X-Gm-Gg: ASbGncs88gOytl8AuIByorSLbokPP9sUcchExcatuJBZXd9FRxPbuc0RPdWhtVFRtl8
	zTS19wWLZtk7VFY5QzjKnTT/bfJjJuDnumgXffHBernn4can/i3Tosqlg6oih3cXRiDsYDIzmUz
	KRF5gRULjsHrQX2BZw986wlBVfYqB4XUnIX7x7rvjbzSX3vBzz9YCxw4kuWBaeNStZSlqCmceao
	uRbG9BPNQVAOEpV2nMX1nMu3cVN8xAWHkNpTa7Sg4i2dGPghpXFiBvzoPiShG3hEyL5TwP3t+yu
	M57mPmFfjPbP52aaI1E0IpmjYWOvcHuu+mTZOGPGB7mhqDEDodlbiSgWR7ONLJ2Ayo/VLTsQCGQ
	N0eaO4UadPu+xnHCTbFB3uy45ubeISdlS0fNR3T4pBoEo916AMbo=
X-Received: by 2002:a05:6808:2213:b0:453:f62:de01 with SMTP id 5614622812f47-4536e43a399mr17450b6e.30.1764714655036;
        Tue, 02 Dec 2025 14:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy88N7ZuKZYlIvdZQmy4kg6Oeq+tbP5nzm2BGu6Vun9VEEZ04RppoINDoRk960fJq0ifc1/g==
X-Received: by 2002:a05:6808:2213:b0:453:f62:de01 with SMTP id 5614622812f47-4536e43a399mr17434b6e.30.1764714654720;
        Tue, 02 Dec 2025 14:30:54 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fcedce6sm7464634a34.16.2025.12.02.14.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:30:54 -0800 (PST)
Message-ID: <54b93378-dcf1-4b04-922d-c8b4393da299@redhat.com>
Date: Tue, 2 Dec 2025 16:30:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH V3 5/4] 9p: fix cache option printing in v9fs_show_options
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com, eadavis@qq.com, Remi Pommarel <repk@triplefau.lt>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 4eb3117888a92 changed the cache= option to accept either string
shortcuts or bitfield values. It also changed /proc/mounts to emit the
option as the hexadecimal numeric value rather than the shortcut string.

However, by printing "cache=%x" without the leading 0x, shortcuts such
as "cache=loose" will emit "cache=f" and 'f' is not a string that is
parseable by kstrtoint(), so remounting may fail if a remount with
"cache=f" is attempted.

Fix this by adding the 0x prefix to the hexadecimal value shown in
/proc/mounts.

Fixes: 4eb3117888a92 ("fs/9p: Rework cache modes and add new options to Documentation")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 05fc2ba3c5d4..d684cb406ed6 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -148,7 +148,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%x", v9ses->cache);
+		seq_printf(m, ",cache=0x%x", v9ses->cache);
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);



