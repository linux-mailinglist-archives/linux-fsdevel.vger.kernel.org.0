Return-Path: <linux-fsdevel+bounces-9325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBA83FFB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB98280E52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CF537FC;
	Mon, 29 Jan 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ReYwIs/7";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="MhXoP1eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D04537E7;
	Mon, 29 Jan 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515760; cv=none; b=E1sGzERwFJc+acXqYIc6VQ12xN6eV/3hYYA4p5sQWF1xvDRK4neih1GgMnY84skxYGhytmsj928p5tJOKjogyc+J5U6UN5g58d0vZMNbo7gjrj26g/r0RJVjbSFfwWX+T+v6DTi0UWoBHKyWNkGZYICDuCa6Gflf7n1q9ktPyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515760; c=relaxed/simple;
	bh=sOrdau0GamvWHIukB319bDFasFZTPBKgNYMEGNGazj4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=fcgK/1ndvyyVbdmLFGWRIH7Fy7pmO2F0RW8eS98Oy7busKeCxvWw8hLKiepiOpL9geGUQPya6OIOnLzgX/qJKepBnM3fSCpWWh98d1MovJisgCfsA5i1ozzwqLx4A7efJsjnIb+Zy7D8VPbwNBH3THnkG31DsLNPaGaLhrYZBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ReYwIs/7; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=MhXoP1eQ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id EFEEE211A;
	Mon, 29 Jan 2024 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515347;
	bh=mHtFVlGdQT3NlQXqvNi7PsHSg3EPQVtrgac40SxL8CQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=ReYwIs/7rsKMUum49OlcvYARoFaXe8NkykGh9OVAemrQwbi1mKrgu9eLlYI5ynnqs
	 ADKYd/FZwEBD6raZyW9RCavC8V9eDb7jr4YB6q37r8zJEg/78OYmLEuTCkss5FlZH1
	 XMUspqloSkpfcXH0CC/qOtVXS+SKaH2UAOC9RgUg=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 4C34A1D33;
	Mon, 29 Jan 2024 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1706515757;
	bh=mHtFVlGdQT3NlQXqvNi7PsHSg3EPQVtrgac40SxL8CQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=MhXoP1eQRy++X4M6HQL73o3RLT82XyIrdJeQ8fVC5j+Ce3OH+MAe3ZdHQrBcdyxuM
	 /bqq3icfy7ZxMVfHvo/ykZZQG1DG6sXyH2Pk0WsWmcZZCsG5PPT3g6BQCwJh/k8p4S
	 5V5lFs8i+0SfLwsVl3O73qpzFJtkhGPtpzqp6Avo=
Received: from [192.168.211.199] (192.168.211.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 29 Jan 2024 11:09:16 +0300
Message-ID: <92465892-aad4-428d-bcfe-03584d302bb5@paragon-software.com>
Date: Mon, 29 Jan 2024 11:09:16 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/5] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
In-Reply-To: <dedce962-d48d-41d6-bbbf-e95c66daba80@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)


Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/record.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7b6423584eae..6aa3a9d44df1 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -279,7 +279,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, 
struct ATTRIB *attr)
          if (t16 > asize)
              return NULL;

-        if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+        if (le32_to_cpu(attr->res.data_size) > asize - t16)
              return NULL;

          t32 = sizeof(short) * attr->name_len;
-- 
2.34.1


