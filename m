Return-Path: <linux-fsdevel+bounces-78686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I1+CshOoWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:59:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AC1B42EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5932304A0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78CE36CDF7;
	Fri, 27 Feb 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWpzPLLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC58163
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179141; cv=none; b=jMaQ2VEHv09LcfsVqQr8IN3gjEBLjHuvfU+EpUWCNyyDMJ8nqXMIiJuQ978DGWnTBe/6EVE5LojBBCsYd+qmwqcR/0lkIt8MzCeUkuCKZvCckt1Dl/fBVdg/8IHRp7ePEs+DP64xJjSSDma7e6adVcvxpyp4IWmajwfTcXyRQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179141; c=relaxed/simple;
	bh=4+TUB7yoSoPLv12gu4rBUAUm93w/iLQPRp1YBDrUtRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lXevIZSwRmze46ZydGl0/Ov4gVMKGCZGGf0oqALoCpm5vbWUX3IskVFDQQhHh+TEApt32GUHfzhbdGAGWMnCyS1PicjMtsDKWRZq6AgriBZvbXYJ2YLZ55xjFl+cdV/GwT15KjIwN9U1opCc+nVmQlcbq1tO4ETnbrpmRlrU0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWpzPLLF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4398c7083d7so1496162f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 23:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772179138; x=1772783938; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2QrhCbecYwCtjU+xCj5mYbcpftK/AETlZM6xQRfUMg=;
        b=XWpzPLLFutmdKjx8yvtYYGjaIFTMEummSwZduWy8CeB+LR4eQR//39XX3JlfAoy1Eq
         5KKtMBBHSkXM20/+RBnHyVyMrhdbwrVyCaAdMqmnnsmIjZEtU2A/L7DMNjkcX/I4cFxd
         fUBUvpxRvFZUogHftnnaFGBMogbUYO4F/3GqyBmVZC44NWUwvi6Z3SfvjG5lt7n8JT86
         Amx9ew9ZTjjOPza67QvNz6y97O7Z6aDhg532BzpjL5qo18/IxTWek2cbnY+EBy1eKXly
         dkZEv/hRjXlY4k7UePFWt65Md51M20QERAFXThLJlvTcWw0uBXJrpjkKTkPEyxK+hZ/L
         kkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772179138; x=1772783938;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2QrhCbecYwCtjU+xCj5mYbcpftK/AETlZM6xQRfUMg=;
        b=I+vaIqXqGEPtguOLTgO28FVGSWr87fKQ0FxEvWcD8f37VcOJMcdEb77HH4IsoD4R4z
         VAky3rxNJ5wYEpfojVjLwHiN0klD/NoEGxGnfmd+wsX6PPx8/5wYwRfjdpEkmuuFAjbk
         qvu6j3zf8yi3FRB2Ajkx5U+wyqiNE/448pDNPM41hMGZHDP3P/cG5R/4Kf3rTShhvtAx
         HqKs1PF3zvFc0dXTjaUS7kjXcpx2cQVY53qaH2pj9nnI0Pa5iCBpZjFg0JE9SxdbgjVS
         v4UyGod8izq+whrz8K1qTVqbDyF5UYlT7keuV80ghClg6U9oet/ieoMb0F6dTpzHUliO
         rjQQ==
X-Gm-Message-State: AOJu0YwzgmoUJf1ZaWZjMDlKiY3sIO2/o6KLxtQi1gnGTqnVciAMSmWd
	tQWTmIBh0c7/3HXZVEpdVex2h88a8julgY6eM/PdE3K+gU7zK1wYp4sxou9Ihrw3FLL4rg7aejr
	067kZ
X-Gm-Gg: ATEYQzwwwvoMqiwMZfwu1kSDOI96Eitka5LdGpEpaUZgjoo42MGAv65HLzCOnlUWAoI
	EZFYLh14vYDF3O/L0cxGxpinpGC1/rAOkL/cPInxRxOTgxxRvIN9RDsrhZ5hPlZ2HjVDRkKJ83r
	hYnz7BUP25T5W5YvVBZYxlzfkBvSEMo37O8fFntTLXE0TwI3rHK6CFb+EnIHsstb+nLZZAfW2D5
	xlM8JAGokAbdjNMQ1t9i+vv3b8bQg3YjH/iEqlQt3Bc1ThIRbMGAWvZ6KMZ7SmBCSo2wgfclkw8
	fj0B93LKoajWn4mRO5L6IlUBHfKB/rNxkQz1Htd9lXOxPsoDX9VULCOo3E5MCEx4tWEpiVxmlSs
	ZIisQX6cHFbf/K3aly7r4EfWVePHr6ju614AaVdBQJ/kDVZ4Qs5lEgEDjyIdeXPhOmL/MR0GAGV
	9bT6SpTJx1n2O4dljkM5wKKZ8DxxUO
X-Received: by 2002:a05:6000:2007:b0:437:6dc8:c372 with SMTP id ffacd0b85a97d-4399de194e5mr2810738f8f.38.1772179138126;
        Thu, 26 Feb 2026 23:58:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b272sm5041677f8f.24.2026.02.26.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:58:57 -0800 (PST)
Date: Fri, 27 Feb 2026 10:58:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] ntfs: update attrib operations
Message-ID: <aaFOvvCNNEsDXXBT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78686-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,stanley.mountain:mid]
X-Rspamd-Queue-Id: C58AC1B42EF
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Namjae Jeon,

Commit 495e90fa3348 ("ntfs: update attrib operations") from Feb 13,
2026 (linux-next), leads to the following Smatch static checker
warning:

	fs/ntfs/attrib.c:5197 ntfs_non_resident_attr_collapse_range()
	warn: inconsistent returns '&ni->runlist.lock'.

fs/ntfs/attrib.c
    5107 int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len)
    5108 {
    5109         struct ntfs_volume *vol = ni->vol;
    5110         struct runlist_element *punch_rl, *rl;
    5111         struct ntfs_attr_search_ctx *ctx = NULL;
    5112         s64 end_vcn;
    5113         int dst_cnt;
    5114         int ret;
    5115         size_t new_rl_cnt;
    5116 
    5117         if (NInoAttr(ni) || ni->type != AT_DATA)
    5118                 return -EOPNOTSUPP;
    5119 
    5120         end_vcn = ntfs_bytes_to_cluster(vol, ni->allocated_size);
    5121         if (start_vcn >= end_vcn)
    5122                 return -EINVAL;
    5123 
    5124         down_write(&ni->runlist.lock);
    5125         ret = ntfs_attr_map_whole_runlist(ni);
    5126         if (ret)
    5127                 return ret;

up_write(&ni->runlist.lock) before returning.

    5128 
    5129         len = min(len, end_vcn - start_vcn);
    5130         for (rl = ni->runlist.rl, dst_cnt = 0; rl && rl->length; rl++)
    5131                 dst_cnt++;
    5132         rl = ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
    5133         if (!rl) {
    5134                 up_write(&ni->runlist.lock);
    5135                 return -EIO;
    5136         }
    5137 
    5138         rl = ntfs_rl_collapse_range(ni->runlist.rl, dst_cnt + 1,
    5139                                     start_vcn, len, &punch_rl, &new_rl_cnt);
    5140         if (IS_ERR(rl)) {
    5141                 up_write(&ni->runlist.lock);
    5142                 return PTR_ERR(rl);
    5143         }
    5144         ni->runlist.rl = rl;
    5145         ni->runlist.count = new_rl_cnt;
    5146 
    5147         ni->allocated_size -= ntfs_cluster_to_bytes(vol, len);
    5148         if (ni->data_size > ntfs_cluster_to_bytes(vol, start_vcn)) {
    5149                 if (ni->data_size > ntfs_cluster_to_bytes(vol, (start_vcn + len)))
    5150                         ni->data_size -= ntfs_cluster_to_bytes(vol, len);
    5151                 else
    5152                         ni->data_size = ntfs_cluster_to_bytes(vol, start_vcn);
    5153         }
    5154         if (ni->initialized_size > ntfs_cluster_to_bytes(vol, start_vcn)) {
    5155                 if (ni->initialized_size >
    5156                     ntfs_cluster_to_bytes(vol, start_vcn + len))
    5157                         ni->initialized_size -= ntfs_cluster_to_bytes(vol, len);
    5158                 else
    5159                         ni->initialized_size = ntfs_cluster_to_bytes(vol, start_vcn);
    5160         }
    5161 
    5162         if (ni->allocated_size > 0) {
    5163                 ret = ntfs_attr_update_mapping_pairs(ni, 0);
    5164                 if (ret) {
    5165                         up_write(&ni->runlist.lock);
    5166                         goto out_rl;
    5167                 }
    5168         }
    5169         up_write(&ni->runlist.lock);
    5170 
    5171         ctx = ntfs_attr_get_search_ctx(ni, NULL);
    5172         if (!ctx) {
    5173                 ret = -ENOMEM;
    5174                 goto out_rl;
    5175         }
    5176 
    5177         ret = ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
    5178                                0, NULL, 0, ctx);
    5179         if (ret)
    5180                 goto out_ctx;
    5181 
    5182         ctx->attr->data.non_resident.data_size = cpu_to_le64(ni->data_size);
    5183         ctx->attr->data.non_resident.initialized_size = cpu_to_le64(ni->initialized_size);
    5184         if (ni->allocated_size == 0)
    5185                 ntfs_attr_make_resident(ni, ctx);
    5186         mark_mft_record_dirty(ctx->ntfs_ino);
    5187 
    5188         ret = ntfs_cluster_free_from_rl(vol, punch_rl);
    5189         if (ret)
    5190                 ntfs_error(vol->sb, "Freeing of clusters failed");
    5191 out_ctx:
    5192         if (ctx)
    5193                 ntfs_attr_put_search_ctx(ctx);
    5194 out_rl:
    5195         kvfree(punch_rl);
    5196         mark_mft_record_dirty(ni);
--> 5197         return ret;
    5198 }

regards,
dan carpenter

