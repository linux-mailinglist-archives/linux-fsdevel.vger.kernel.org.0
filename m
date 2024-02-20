Return-Path: <linux-fsdevel+bounces-12182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E885CA1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 22:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F77B22C07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F461151CEE;
	Tue, 20 Feb 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4RvJHQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341F151CEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465338; cv=none; b=PZ4XHMemdjtj4lF1x8bBwL4JowgN2A0KNGPBVeV+hh6fVPWBPMh6Kq64mXMGLUqwZ4Y8S5DMXYdkeuOvTmtT8De1oJFd4RSd8txELCbQ5R9FyiuCfK47IAxyAYGDKfzzNx73tQXpWF7W7wmliqCb3OReiG++DFpeNiw7uUEIsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465338; c=relaxed/simple;
	bh=dOxiPLE2wbFZ3O9+gM+vq4M9Xj2MF/ar3bvEQjcOl58=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eZiVVJdStVJXk12JTAUwBlsmZ231vYDD6WonfFKtZg1jsji4iVU40urilTKmD0ebrKaHjzG64hX+74qVUc48wImMkfnfU6oQj3drX02pOIBUfuLi/HIlNz5IXBPyqDXPX/QjMnjqI9AdyqHNK8pEdIBg59bD2Tsk7DLcyEluYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4RvJHQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708465335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dOxiPLE2wbFZ3O9+gM+vq4M9Xj2MF/ar3bvEQjcOl58=;
	b=H4RvJHQe7q1crqQQFUIzeI1A791NdL6TDLRT59/sUhH0h6zLrI9ZP/2cFsi2eoqaeJ87Lc
	rkua5f0TliZEc1GKQKVpZUe6Bn/p0tEf/N4FOuHkIMGhLTnvuLM1dECqiipgVnjDlFUxvg
	IJIFNCi28YRfXnYpw0vxdBWnqbTwITM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-PgSJ8nnaMjaCS40PApo0QA-1; Tue, 20 Feb 2024 16:42:04 -0500
X-MC-Unique: PgSJ8nnaMjaCS40PApo0QA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so754168339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 13:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465323; x=1709070123;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOxiPLE2wbFZ3O9+gM+vq4M9Xj2MF/ar3bvEQjcOl58=;
        b=tClt5Bn3P20qwtV3P0M8M3t6aUf47onytv+gMDEqFc8O0IWTdsB+tQewdh2s363UaF
         PT6S2qdgRx5iC8qSRD+1S67c6mlpiwaFasVSJsIPYo7jLHtMbWoE+YWqF0H1t51Fz476
         K6mZnl3uVM7BVQll3GeDnOSFME5KlyF1bFCVwXubb2bNlwjDVra27uf192BPRqPYG+n+
         15CtdN5DkLnNofWCUibpCj9x+DHyRSpKHu4JxZ7VG7KmWslBJp7pkAEX2upFFAJoHS1m
         8LFQtic/ZHswsHjTlWTYxR0TwJAIl8/5z4iUBxQNa2EMRyb9G343aFsqkErPJDmEAoDM
         CWNQ==
X-Gm-Message-State: AOJu0Yx57QbKivqOTr7aJ8UolgpqlD/Zi9+itXAKwWfnwzTOcSbg1Lpl
	7MNcXa52H88BDXD2y9sqwbcIiUdmjPjgWVyINzMLacE+8spbB5nXqu3x+EmmRLL/vvhrV/sa+O3
	Er8h2HulvlnEXIDnu3r6oWMIqjkgmOnXi0Chx/acarKVuX9tLefl3TM++W0ts4qs/fecM1kd5JY
	DqMkBM7UMDsLAFAxhQwYczlYBr01iG7xfLvaNYxvjE8SQrLQ==
X-Received: by 2002:a6b:6107:0:b0:7c7:6ea3:c882 with SMTP id v7-20020a6b6107000000b007c76ea3c882mr1271053iob.10.1708465323229;
        Tue, 20 Feb 2024 13:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+eUZiTAM90UQx/twoPiM39QUfVIJ7LBSLhZF4ldKZRP+aYrMoqR0zbVjoBJaNQd0M1gTJWw==
X-Received: by 2002:a6b:6107:0:b0:7c7:6ea3:c882 with SMTP id v7-20020a6b6107000000b007c76ea3c882mr1271024iob.10.1708465322839;
        Tue, 20 Feb 2024 13:42:02 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id ck9-20020a0566383f0900b0047436275c32sm715164jab.1.2024.02.20.13.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:42:02 -0800 (PST)
Message-ID: <ecf5bc91-69fc-45ce-a70c-c0cd84c42766@redhat.com>
Date: Tue, 20 Feb 2024 15:42:00 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
 Bill O'Donnell <billodo@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] udf: convert to new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2nd version of UDF mount API conversion patch(es)

Patch one changes novrs to a flag like other options as Jan
requested.

Patch two converts to new mount API; changes since V1:

* Fix long lines
* Remove double semicolon
* Ensure we free nls_map as needed in udf_free_fc()
* Use fsparam_flag_no for "adinicb" option
* remove stray/uninitialized char *p; in udf_parse_param()
* avoid assigning invalid [ug]ids to the uopt structure

Thanks,
-Eric


