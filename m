Return-Path: <linux-fsdevel+bounces-79706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDOuLBKNrGkCqwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 21:39:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE3722D883
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 21:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3530D301DCD5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A333612FE;
	Sat,  7 Mar 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFb6uIx5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4tA227I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5F1D9A66
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772915978; cv=none; b=X54QuykvGzCXLTcUY5sJ568t7Ny/nGrKOy7PG7T4a07YLg0FJ/wH3EcGGgqf0UIm2hrQ9JtvwxoGBju3CX1KTSlkXGt5LhCddDp2ia/l75UWXHSfsjU94CDT8qqYqg/D7bYDfsUKWBELnBX16fVaVPO+ugrQRjULWLs+fSeq1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772915978; c=relaxed/simple;
	bh=1wNXwrUo3UJjkzs5KJCShM2dOrnW6rmk1ulLrPJOqAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=DfMOWptt1PHgrAZVgJO3FBCi5wr9Q9V65uNbXpu8gEyCEdTZ8sg2LhCeqcHb0fIOfSGseIu+V/7rKnq6Ca2M1qe/RgOcGbZJigLaZG2AqxV14bDGulQTe8TiiGECZWVRDdCcAeFTg5+IArdMmHnkVdtKtiiyEB5cx1QTux9yf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFb6uIx5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4tA227I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772915976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T9OxiP3l3t/dSfco7PULw7gMtUpegbGKrMUBctUMchM=;
	b=FFb6uIx5kS7ctTahWPukZ5iL4WPM92b4kqn3koNSKTBW5AwSxKfrZSKngC65t6wbCcuHdk
	JDF1XDDIxmN1SqVHz493wKPVsvCQnuOsXdR8kGgICfBFGF7zvT3cw3WkbRAzgUJfYE6mlA
	wj07Sgl6X0m+mX+wZIwwp7tnjhQafMs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-QaC6UeBgNNih4fN-Q2oe0A-1; Sat, 07 Mar 2026 15:39:34 -0500
X-MC-Unique: QaC6UeBgNNih4fN-Q2oe0A-1
X-Mimecast-MFC-AGG-ID: QaC6UeBgNNih4fN-Q2oe0A_1772915974
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899f1c1e4d6so732796956d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772915973; x=1773520773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9OxiP3l3t/dSfco7PULw7gMtUpegbGKrMUBctUMchM=;
        b=K4tA227IdFgBbZ9kxBUSZmaCbTXTp1GXLoSbJCEkK/o8pry0gnijLUTHuHJDt0iSYP
         k8Gvkc7/Pw7qPtyZSyn31Tr6Man8RCN6H51LaZmm0rrWOHoQKmJFxavTXrxloGq6+ZEB
         UmP6bcFVRig5IKIUZKH/PyHAGh7ppUizLOCHoThp1kxvVZsk+bqLttLDA44mZF8gqAXH
         V2wDqpVJFPjzAv0zapNhyJm+cDcEbDpVC6byDfBJmETjI7Xvh8sgONykYGuAcHOFzLQj
         fbMkzDwvUj3yc0aGRZAujs11KseidZrVoZMDvgF8xnItmhCkz7aXy7CoiyVLpvsYqXls
         vvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772915973; x=1773520773;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9OxiP3l3t/dSfco7PULw7gMtUpegbGKrMUBctUMchM=;
        b=Ag8rRVxiJGLdQ11+6J658eWFOD94bu1Z0rnK7fG+YTpnCBR9GMZwseVXwibPeMR6Zx
         F73P4oaPloyZ2Fe5b3CFUEXLwvEVshae3grGvt1tlSdkuwraKRpVuw5SNQnn1BWphP1M
         x0Ek8fus0aC9GNrNpHlpRnSX20GykOqHVO2G4I4VwsKcMNLbkPDdYZpJwjoOmUsgkCk8
         jiRNwDo1fzW3XuyDZMGlHD3u5KaJ05NcAz0y+c2nGJbKM6bohhUWHDRxD2cbcKFCI3xA
         ZFVrayOu50OI9ZyF4afh+oUse4JWzDBql4TL84Zh83Mq9HLqLDF5mGOLtbPApkhxll/k
         WKhA==
X-Gm-Message-State: AOJu0Yz5+yI80sLBhq/qgd9sDeAvO6VpdY5/T94MvNA+Hu7Y/z1vkOtC
	Qc6gdgSfc5OLIGiQKY+IRin5kW2RWxRn/PAvgoirOP5Jz+CxW5VHEbP/d6zLRASiZRrg/JqRwDI
	zB+m9dFTdarZNwkUPmfQrgLZwYnd2wxlq3l91VRI+9KzhGo1rR26Jhu1IjPJQK6AmscywkgsWK1
	w=
X-Gm-Gg: ATEYQzxqsm4A9mt+9gt+xpEMTOwpnArZt2A+gXoVya4qAXSlnupENQzx6FCWYVh6Czy
	26kEcs56ZWNpvapuVadONDck6CUE6jKBfNPRo8YHDfvzve6eHFpe/1nmWvTV6SU4jMYC60mO7N7
	xOBpkmkKMUxNmmhEE/BYSsWushmLPTNSY71wm2sXIKlh9FsAQS4bGGRohyO0DEZXP2ClIyYWTaK
	RcxuQ4mR2LZZKOufBDgFTCpU4cSROZMErhQxC2ZbXlv8Pz7FR4KlUaQsyzUQ438BZJQFMtpA8eP
	qttDC58kaHtGpacFekjOcuF5PrNHdOlxitaLhPn0/CiiR8LFYCbpHtJoj4rW0eMqbNBwnEP8XDV
	6VlCG16Ys+dsyAhgkhfbQ
X-Received: by 2002:a05:620a:2946:b0:8c6:a8a6:e164 with SMTP id af79cd13be357-8cd6d4b504cmr848458685a.45.1772915972795;
        Sat, 07 Mar 2026 12:39:32 -0800 (PST)
X-Received: by 2002:a05:620a:2946:b0:8c6:a8a6:e164 with SMTP id af79cd13be357-8cd6d4b504cmr848457185a.45.1772915972417;
        Sat, 07 Mar 2026 12:39:32 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f56da77sm389027585a.44.2026.03.07.12.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 12:39:31 -0800 (PST)
Message-ID: <4d58bf28-a3e0-4496-bae8-05387da27054@redhat.com>
Date: Sat, 7 Mar 2026 15:39:30 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.6 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5FE3722D883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79706-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

This release contains the following:

     * CVE-2025-12801 resolved
     * gssd improvements.
     * nfsrahead updates.
     * nfsdctl fixes.
     * A number of other bug fixes.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.6/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.6

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.6/2.8.6-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.6/2.8.6-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


