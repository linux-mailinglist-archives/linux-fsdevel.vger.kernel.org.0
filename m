Return-Path: <linux-fsdevel+bounces-76036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC1+BGaPgGkl+wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 12:49:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5860ECBEBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 12:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B11253033D21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDE36402F;
	Mon,  2 Feb 2026 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn/Y/26a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjnKx5gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204403644C8
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032738; cv=none; b=cLyGRClrtpUmv753ZNLewgo6dt9mhJ0wcMcXhsJbVDGEsgeI8VVadjEVNrjEdBdepoo4XR0UZ+9DMuDiOM7ux8pJkED4zFAs7ZWtPzNxCAq00BJZdQcOzaXUceHe3LxQBcPpj4FNBCRE3SyJDwwwC4htUU6WuV/S7IJFcn+w7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032738; c=relaxed/simple;
	bh=hUCc5qc1wPl0eDRsEu95AnTZAcSjNecW9O8G5FUbxEw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hGH9CLPMtDS+LRxLrF4z3rCaboarvbdolgIWrB2E7bH1/L61knooroQNxdHEZrgC4NC+2vjuU7Q0Zvg4hpONOFn7OyLQPBwtj3/r4p06MKj6ISq2SSdkFgswWBkD8cIQ8mAq+SzD+BMrDd4HnqV7elG1NNBiV/NFDQ7LM18q2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn/Y/26a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjnKx5gp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770032735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
	b=Mn/Y/26aBtyaXD5IKq6+rd8HBePz6x2MiAzMielfswC799t07HQocpq0iDKERtkEqBPrsm
	E9priVwBZ9owYcrhvNvlbE+emylBbUlzuVStj8Y86QQQeT1w5Ma4mD1b620D5cx+QYjRKp
	TBDx12/Vc4zvhu4KeFRW8YtJp+oCy34=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-qZPSlpC-OaewuyLecpD0Ng-1; Mon, 02 Feb 2026 06:45:33 -0500
X-MC-Unique: qZPSlpC-OaewuyLecpD0Ng-1
X-Mimecast-MFC-AGG-ID: qZPSlpC-OaewuyLecpD0Ng_1770032733
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52d3be24cso690563585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770032732; x=1770637532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
        b=EjnKx5gp+YCVnzXrBP6ciXZPSFseW7xRreLS1dF6WZto0E4OC1AzX/aFa7jrJbFUJ/
         ESgDpNMOi5exmyzvW/75W6f5Qad16P81VRuzueGLDDgBcPbsWOJUjsHPgvQP3bYfduiZ
         uYp5uJjnk0O1cHv4jGE44yVFqRN6RSHuUqsRfI2S9D0MZuk1cdSSVnhtVNtNSa4m+5ys
         dpBXSm0w828vafv12GBcblL3kr6SkGqNLwUPszeYkN0u9T9xfyj7Y91WiyG8wnS8/6TD
         FnJUH5KhrUN0gkJ1A6oKwM5ZMq/C/5z7KzKosr3A3TopxFRhbbu+m1cF0obm8snLUA/x
         JZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032732; x=1770637532;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0x2TY/gu1Onlqu/1pckH2+z3ENgTf6K7YsnU3XKRWE=;
        b=huaw8BiSFVqyGFQOdQKLTr/Kb1shw214WXpHzdSk9xZfxhJbHqTbeAMPA4FXtRIp/x
         Cy9IX6mJ4nQPHe6Pm08gn4gm3B1qRtdZrv0f/28Fm+3LkftdyuwEqIGnPJ9Yv3E462JN
         6U6A79efQZ/vsoXlir6iTaCOMUG8GQeFZoQK3bxah3EVy7yjA56Wkm4CXr8paNtC6Qw8
         mqC/kFyXYkLqBOAhm9Zl1PAkYR6+HLIuXiNWX8cbQrLs1fAwOUeSmPwFow9dHe2CCuxx
         4roPxFlBZttHtbK1tRA2me+8lKMzZaNCpVzSQTDW4GeOtzvh/fi1u0J8jry9zJKUcAPr
         eDeA==
X-Gm-Message-State: AOJu0YzSa4LaatPT+oSyo+0A/QKAzf0/vx62b9gXlEYaVtgQI47zpmFa
	/Qp5i50pyTdiXeQudvQooTPpdSpL8ydfKiX+4Panq+7iH2sOg0TQ8yEcWxk6NqGHE3fEhPlb29G
	J1jwqD6b9Z17/FiwTa3m0vqt5htQ65LwqfNA7PqsBxYH62lt91wVHw2tt3+RuHjuDV2n156GDwc
	Y=
X-Gm-Gg: AZuq6aJTZ34ipV7N5EJZ3QPypxPREPqEfVByzkIxXIUTDouC1lWFC77fcrEjnx8nTLx
	fqy6Mtr+HKeqZ1lUTbWaF+ObOIM1s9i3oZiUqLFMLWKh43tdtW7VgUx5EbH4RnUsxVl3VbJ6UNm
	T656dgwtof7qnAz3YI2LOtdozRbtm/8x/zLGPDvLai1rZYeQ1nuzSkk5LQLsn3ZHkHNg13PWIDr
	hzICn/FAOzQJidJ9uWzr5DOLVT/OHEjR/LtePiY2tyCY87FFhri1hJXZq/jpxtFDHcjM3M7XakG
	ykkhxm5jMrfoV4s2rXGoDd7OfZ8m+1QmECtrTpAhK22qPMCDaCl90eNO1AfhqR1pkZMrK2EHGd4
	7ZW8LCRY5
X-Received: by 2002:a05:620a:3191:b0:8c6:a809:862a with SMTP id af79cd13be357-8c9eb2fad23mr1443294285a.45.1770032732333;
        Mon, 02 Feb 2026 03:45:32 -0800 (PST)
X-Received: by 2002:a05:620a:3191:b0:8c6:a809:862a with SMTP id af79cd13be357-8c9eb2fad23mr1443292885a.45.1770032731952;
        Mon, 02 Feb 2026 03:45:31 -0800 (PST)
Received: from [172.31.1.12] ([70.105.242.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894dae83f1fsm99553146d6.38.2026.02.02.03.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 03:45:31 -0800 (PST)
Message-ID: <fdf3631f-e924-4e4c-bd9f-db5b40a90bfe@redhat.com>
Date: Mon, 2 Feb 2026 06:45:30 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.5 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76036-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5860ECBEBF
X-Rspamd-Action: no action

Hello,

This release contains the following:

     * Man page corrections
     * min-threads parameter added to nfsdctl.
     * systemd updates to rpc-statd-notify.
     * blkmapd not built by default (--enable-blkmapd to re-enable)
     * A number of other bug fixes.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.5

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.5/2.8.5-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.5-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


