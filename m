Return-Path: <linux-fsdevel+bounces-14413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D471587C1F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 18:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C2283439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1CD745E0;
	Thu, 14 Mar 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="egBYLjzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17841745C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436561; cv=none; b=UZJ5FwXOYyEzd1YMjnIkRN9KaMoKWfcPWsJ+1f55rzA41wImbcWElpntem+J0strNcytFjjrDq4rBxGVZLsQ80hsOlVumEi3xpde+vZLUjCSUleUxAqKWk7Mchw9xNnykTN6sjXcOsrSEg6q/i4GUNl8Fy90fMJGtIRCdKsJQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436561; c=relaxed/simple;
	bh=ASo+LDsMApRbUXPpMln5pwSC4HMvJj/Gm7MdWQsFt1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDx6myBrfmhf9t59xe+EBwLUM7dNnUC/tyfCx2ce2EPL1FBf8vzwuf7RWIIaBnGNC8KoeEL9vkDF0OqSfbwvFHPJLszm6dkndLFnpEsfwLU8uveiOKUiPj9fiFbG1CyLEtL9OY6Bv8UKk9pQ6VUkWCvBwtz1vvm7fUhKHzezLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=egBYLjzN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46807a7d3fso6339166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710436557; x=1711041357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95r3OCCclHMX2hfHWchTVWQ72JjnvU4/ijqwnCext1M=;
        b=egBYLjzNyavAZpzF1XcRfh/wH6l+W99Ub6q5Kg2yw+Xz/DcKV2cQ2CxyMqRTBp90OI
         av4A0Cqvvo8KLTXbOhR0M9BpfRUe0JyPRuche4MGPK7ag1IgvzozO5DGCWaYySItwKfp
         1qwQNvDUPUFhQqiM1QT2ebx+AB8z003K6OzgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436557; x=1711041357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95r3OCCclHMX2hfHWchTVWQ72JjnvU4/ijqwnCext1M=;
        b=imfMzeZArF7I0sD6/2OjaFyRfnj3a2t8clflxLnGMvn4UziTk1YnhuB0sSI0T45D7r
         344DhxSFDf+fJCRH2oaLmtB0d4NSVTGQOezu7gCQWdi1anPWJXZkLB3TCDdDeUExiOO1
         twQjq4QhR8ExSNTFz2j36O30iOPWV/7YRgQEoDMQPRh0trEdz04SIqudwu39QG6+d72X
         MIYAFZRD5hHz0r/MN8q9ApKvk/nB7ZxTkAQ7A6UG8RXOAOAM9b2vuPS5SVJdnR2GMqGj
         piQo+H0BKgpwNk39Kg8JRKExAXHBqvQFLb/IX+h5jai2SQ2TFnDJvvAGtCdrxFXSDCp0
         6IMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZP/Wdm0kNPyW34CIOLMD4E4Wa67AyB0NBZhCvF8rTiEGyQDUpO9DtSZk6Lplt5fXDkkOTAwdiQjYI17vQB4WDEjWF9MKiLFy5oY37w==
X-Gm-Message-State: AOJu0YwVJ3XtfEUpzpavPIPcvJoAyH8D2vEXhSnRDbd/Nl6Rt6gGt5f8
	NTva5S5U2xFH9HZwxRSdqwbhu/7MQ2uYSLX7E0wizKrosN4wZFfvkrL9a8o/RIQm/9xgnqMwOCH
	wftnCwQ==
X-Google-Smtp-Source: AGHT+IGy+ThFrnyIDhx1et7kKYAwYe64+4Z0Jn+cl/uorvrIrT3KS0CNCgz4FQkF1/fDMDSAVrYV8g==
X-Received: by 2002:a17:906:695a:b0:a46:6510:a824 with SMTP id c26-20020a170906695a00b00a466510a824mr3936484ejs.19.1710436557336;
        Thu, 14 Mar 2024 10:15:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id dc10-20020a170906c7ca00b00a465b72a1f3sm867760ejb.85.2024.03.14.10.15.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:15:57 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a450615d1c4so206901466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaxwaYfQ+WHQPXzvZgdlHy6hZW+0xJSUbVFDB7L9CHOOW+7AY1wR6zy847FbYc93eVyrpnKiiSai1LMsDd/P9Ddc1KlfAIzzalVrUV1w==
X-Received: by 2002:a17:907:1b0e:b0:a46:4ea8:9df5 with SMTP id
 mp14-20020a1709071b0e00b00a464ea89df5mr6915486ejc.5.1710436556101; Thu, 14
 Mar 2024 10:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
 <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
 <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
 <hbncybkxmlxqukxvfcxcnlc53nrna3hawykbovq3h3u5xpm7iy@6ay4wjnpuqs4> <4q5fetc7qwunhhvieuiubk3g3guc4mr4a5wfmn5u4ox6kyo4p7@olyanpabfvav>
In-Reply-To: <4q5fetc7qwunhhvieuiubk3g3guc4mr4a5wfmn5u4ox6kyo4p7@olyanpabfvav>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Mar 2024 10:15:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaWNYqrH=DSMiKTtb0vO-9JZ8Vm7VQRT4=uprsaT0eMg@mail.gmail.com>
Message-ID: <CAHk-=wgaWNYqrH=DSMiKTtb0vO-9JZ8Vm7VQRT4=uprsaT0eMg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 15:28, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sorry, you were talking about mean absolute deviation; that does work
> here.

Yes, I meant mean, not median.

But the confusion is my fault - I wrote MAD and then to "explain"
that, I put "median" in my own email - so you read it right the first
time, and it was just me being sloppy and confusing things.

They are both called MAD in their own contexts, and they are much too
easy to confuse.

My bad,

               Linus

