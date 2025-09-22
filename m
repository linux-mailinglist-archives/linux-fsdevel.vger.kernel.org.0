Return-Path: <linux-fsdevel+bounces-62430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436FEB935A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA67165CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02BE83A14;
	Mon, 22 Sep 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V2kwE56p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41D261B78
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575545; cv=none; b=pi3mnKRtXyL7HPoNj0NV++7qtRnTBFyzLsmkjK/HDQfqb8KRsYcezBZow8E5H6Hwyq1f2pM+evCAWZ0sB+U/b1javaah5xoYWNds/w116va0PuFNG0tMANRyp7Hs+pwve8cSIYIR+HRu3Ye7iQOIEjCRccVNqupvOX+B7XZkgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575545; c=relaxed/simple;
	bh=cjmOlabpDRHO6Vh0Y195fc83zAPlx04S+9ZsHcHhlaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFFnbFRN8YjoPeebo2vWvisjZznzGxwqM6bjlpx+4DsVQEWwHoHZsbyOT76A4J0I+6dPAm30vPcPgltq2cHHG4U4KeK6V5pNlSiezdTYWFfkUY9kvJmidpkXdfbGvSuTPf6p46JysBHyHKOwFPi0nSCOszLU+nfh8dAV1Yqk7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V2kwE56p; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B345A3F52A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 21:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758575530;
	bh=elS6AM80OAc21lYSpfxCP2x/lAA3B3GyFLeOM2nq0so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=V2kwE56pcaLX71mY/2ztPhm4W6DM5xOrgCaHS/wvY4yjwN+EvLUZvn35WTJQ6wybh
	 yA3tbDS4nI7dhVlRId3r8b4JebqTJ0NM/hHhICH5QWKYDAlMKzrwnAcILjBdGrIVul
	 uAAHHbeEdZhmwH3nWuaINr4vNJMQPGYzcNj5VOs9GwJsN5YyHXv+sBszjBP7zGt3sk
	 cksG9imQeThpTO17K8sxcmY8UXShUnk1QYhJZiomMibzfxrCXlvCDY4SCaml/gMujS
	 43i4V9NYG3a+9dplWXCxlPIUZSj4PODHdImrO3ZL3wSOOppWiK3XfExr++PIUxF/7v
	 4MGfZT2kGQ6ow==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-252afdfafe1so50856465ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 14:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575529; x=1759180329;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elS6AM80OAc21lYSpfxCP2x/lAA3B3GyFLeOM2nq0so=;
        b=Zv8Qh0gCQGQyr+/Is+UyWSViWWQF0THO5y5+2N6lb2AwfmjtdEqS7ZmxgOiift4CyE
         HhU5iX4NOmtNrggwJNqm7O+ShOQCm2YBbNFqIsmQIVmQl/5IM+nylBb9AK2JM/2m3hOY
         BOGi178M+NSpHlF6tktWTNVgLDRPi6VxXxLorsA97HMbU4SxgNt0m/K1s04qk4IlGqdt
         LHrCotrcBpKgvD01vAFlz+6CnKscYEqi/BXt0DfzcQTXqEPsZ90TnffK1DlK4dtD7BHx
         +Hgl08stEziX938PusYdI4IzuqiQP1npD/uzxI5Y7Jof8PcKLqk4ckRhl222qTP3yTrM
         b+aw==
X-Gm-Message-State: AOJu0Yws2JcIzl9ArQkmf+UGe275MFk/M4OIBkCoikXU+mRgx2vB08YE
	+dXNoXKYdeWlr4m8l4O5cccaE/zrC7WDUhMRVkEarszqjVQBa9fOTmem4GjMuNXCKcvS2go+7cJ
	JaC98koq4DTqTti8YDA10uftgjozeg58iYKRR/hL8wSl8nnU6F99hHqAoC6tTeLmT2GhmA9dUSA
	S0fAzw7Lc=
X-Gm-Gg: ASbGncsmKLHL/iMr6SsvQuLylR5kMhUIMGwUpP5vUWSyihZDajMntyZNKJ9W6HrY47p
	pvxbDjuR2Cr0fVcer+OJvqa7alT1pNZ8UdRmXuRPR3u0XZxVi9uBFGIWkuuso6uVMsvpxaggVTP
	k9E8lTwOMnGvyOBsxSyyy2PxTJs6Ygcy6k+VBEDz0aE8XkwgXlp9xTxpalNCPOwj09rvSNAj+Lz
	XIN1hXK1skkJYQH3ySr7bOlZg+wToi7pW4ID4tmTjMf502MEEo3V3vmq1OmEfsdM92vcW/5ZIxX
	vfc1XLShwcf9lz94h2gmX3NDNDV7tyF7PGw8uq/6RCm+RoCGS9oU5w==
X-Received: by 2002:a17:902:e88d:b0:269:9adf:839 with SMTP id d9443c01a7336-27cc20ffd3amr3125655ad.19.1758575528834;
        Mon, 22 Sep 2025 14:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtyDqrDs8nuevghsJxLkHgd1PxX+pXXVqz4XbqLerS2YUkBMk33hGOovnFcTFWM1ZnTVqkkg==
X-Received: by 2002:a17:902:e88d:b0:269:9adf:839 with SMTP id d9443c01a7336-27cc20ffd3amr3125415ad.19.1758575528486;
        Mon, 22 Sep 2025 14:12:08 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm142443335ad.126.2025.09.22.14.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:12:08 -0700 (PDT)
Message-ID: <8e506303-f2a8-4efc-a1ee-1c1eb4110f0c@canonical.com>
Date: Mon, 22 Sep 2025 14:12:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/39] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
 brauner@kernel.org, jack@suse.cz, kees@kernel.org, casey@schaufler-ca.com,
 linux-security-module@vger.kernel.org
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-31-viro@zeniv.linux.org.uk>
 <CAHC9VhTRsQtncKx4bkbkSqVXpZyQLHbvKkcaVO-ss21Fq36r+Q@mail.gmail.com>
 <20250921214110.GN39973@ZenIV>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250921214110.GN39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/25 14:41, Al Viro wrote:
> On Sun, Sep 21, 2025 at 04:44:28PM -0400, Paul Moore wrote:
>>> +       dput(dentry);
>>> +       return dentry;  // borrowed
>>>   }
>>
>> Prefer C style comments on their own line:
>>
>>    dput(dentry);
>>    /* borrowed dentry */
>>    return dentry;
> 
> Umm...  IMO that's more of an annotation along the lines of "fallthru"...
> 
>>> @@ -2079,15 +2088,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>>>                  goto err;
>>>          }
>>>
>>> -       fsi->policycap_dir = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
>>> +       dentry = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
>>>                                            &fsi->last_ino);
>>
>> I'd probably keep fsi->policycap_dir in this patch simply to limit the
>> scope of this patch to just the DCACHE_PERSISTENT related changes, but
>> I'm not going to make a big fuss about that.
> 
> Not hard to split that way.  Will do...
> 
> 
> BTW, an unrelated question: does userland care about selinuxfs /null being
> called that (and being on selinuxfs, for that matter)?  Same for the
> apparmor's securityfs /apparmor/.null...
> 

For apparmor the userspace doesn't care, ideally userspace wouldn't even
see it exists.

> If nobody cares, I would rather add an internal-only filesystem with
> root being a character device (1,3) and whatever markings selinux et.al.
> need for it.  With open_devnull(creds) provided for selinux,
> apparmor and whoever else wants to play with neutering descriptors
> on exec...




