Return-Path: <linux-fsdevel+bounces-38001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD89FA19B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103E8168586
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C9154BE4;
	Sat, 21 Dec 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUAQ8Huk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCD1C32
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734798345; cv=none; b=LbugK7HD1uXAnp5QBYZPU0GxfGw2GS/Qwpjv3g4LL0NsVGlip8/wvze6B5JQRpujyS8XXNF3uF8tgZWKcGhwDjFfsLQd0XqQCK9SbzDnnFpY3cfnGZgZkLVFev9jbuO1HiUfwMllFxpwMyWiYYOH48RWFTPJPXW108jPWwLcLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734798345; c=relaxed/simple;
	bh=Ihez4Yt/u0N8IITKprSV71Fz2DQbecUa6ML+HxMDCBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwRgV2Gx111k/KJpMpcw1Fx86EBrYmNIVOzKngOor6icaKMPdr3xgPr1u6nAXx1I81apW/MOj/fGY79nzYql3s8oz2lvfgVY8DNOXhDIhlwpDNtFNEgJjnl20gdxkT7BjQHBwQj7i5g1zoxZQ+JchjN3jUZzxdBOtfnaIU2ybMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUAQ8Huk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734798341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fDQesCFyjrUTB2hrzO2XouBbHYNmP9E8Ch4RIGJLv/w=;
	b=KUAQ8HukFKun2M2wNPOYy3E1CoPq+g0c8DXqYIs/Xgux9VDQFRKLkqM6kliUg5KTXXKdRr
	gku8RZRajvwE+HZdxcxQMgpvDwRwhfI9Low0O1zRztBWwzbfp7SLWWccEHG+l2WhSj3aCM
	g4Vwyzm7oKmNYxkaRZ5rW/cQYlt/9eQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-IyXKY-cyPPShh91o5ywT4Q-1; Sat, 21 Dec 2024 11:25:39 -0500
X-MC-Unique: IyXKY-cyPPShh91o5ywT4Q-1
X-Mimecast-MFC-AGG-ID: IyXKY-cyPPShh91o5ywT4Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362552ce62so15814935e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 08:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734798338; x=1735403138;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDQesCFyjrUTB2hrzO2XouBbHYNmP9E8Ch4RIGJLv/w=;
        b=rpo6ibf90VSNDj8jeINdwYDjU0OVJTwVAqMZUe0blwp1sbjoZqcRoqQSD3SfGEZT1A
         W64WGSPT9KnS2YKYN59MDjzizv4e/HgrIenXIyy6yBS+IkWocaWwgdeCKBcIjb/1sCNZ
         wSUFsBAZBlmG3UPPQYw71OzIOaMwpPOdGMqqyYnCJeNKHt6iYSRsRjMHu+Pe+LKwlF95
         7VcrsPWmSzX2xp+8GsB7MoVFdSh1QleR8x+q8Q8fWIG4sk3ISEhlZH3ZN9v66od71Oqe
         WLyB8tIa6K6QFQM8O9N2dfqSVUZ0LYUaBXXhMpLiMZ2AfAknyTzv2ZZ7SueEZmjU+PBX
         2mHw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Rlv2B4TZMmh8atXYL/jo4VDlp9cUziJs/3GWsb6YMS+jJAQxJsAotZnBN42b3w8WmCeYiizaCz1MR7fJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvC1ABCti5Hwap7aO4WqL+EU6DpgqbfCMHNEgbf6/QENrWo1a
	wzYzO+voO28uFoaJRsyxvpL2Xwqb+iJUUdkJXWpgNGqUBYuojxDeJJl0ADgNlWnsqJkP381dxCb
	BmkoW+BXPk6sWIutPF8Abc4xpDaZBKA+srsLLPy/PS1sTa/noz+f5hTJ3XoeHkaM=
X-Gm-Gg: ASbGncv9oIUVDXtr8zDCV/pKDpxs/it+jhs46RLKRJtedp1TPA4KAeyxV1CmwDT0aCM
	h1vfeAlzvJy4EU1Z4wqrVrAk8dSVAAZEY75QXdOYNvwA7Udp+YPMwKsaRz8EmqJp5K5fhA47UgT
	twd/D58hSjTljNJWaG2C202Yv5Wj87QB8Mjhfd9VM/ANTuQp5aMyQX7OTt111AAAWqJSooaiNq1
	IRCBnvBNpDhiyX9hmbRaVubORSzc+0IvequigxtypM7iT1VUANeyo40p4VHCaxNYotnmA79w1lw
	OK6dEvpNKHzNzw9NQjbuWFWDCKp0njnMVL8kyVITMR++qANgQ2bQ4gaGKBEyqGTF3zREcXoGCmU
	CMqpQ8dR/
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-43668b7a1dfmr58358055e9.29.1734798338394;
        Sat, 21 Dec 2024 08:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdIo3QvtPFQxjuogz9/xD0yFo6Z3O9wt38AlNPXCP6TlOu47D7zaCO8TMixt6Ey3nx6lbo4Q==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-43668b7a1dfmr58357895e9.29.1734798337965;
        Sat, 21 Dec 2024 08:25:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d? (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de. [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436724169afsm28333895e9.25.2024.12.21.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 08:25:36 -0800 (PST)
Message-ID: <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com>
Date: Sat, 21 Dec 2024 17:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.12.24 22:01, Joanne Koong wrote:
> On Fri, Dec 20, 2024 at 6:49 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> I'm wondering if there would be a way to just "cancel" the writeback and
>>>> mark the folio dirty again. That way it could be migrated, but not
>>>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>>>> thing.
>>>>
>>>
>>> That is what I basically meant with short timeouts. Obviously it is not
>>> that simple to cancel the request and to retry - it would add in quite
>>> some complexity, if all the issues that arise can be solved at all.
>>
>> At least it would keep that out of core-mm.
>>
>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
>> try to improve such scenarios, not acknowledge and integrate them, then
>> work around using timeouts that must be manually configured, and ca
>> likely no be default enabled because it could hurt reasonable use cases :(
>>
>> Right now we clear the writeback flag immediately, indicating that data
>> was written back, when in fact it was not written back at all. I suspect
>> fsync() currently handles that manually already, to wait for any of the
>> allocated pages to actually get written back by user space, so we have
>> control over when something was *actually* written back.
>>
>>
>> Similar to your proposal, I wonder if there could be a way to request
>> fuse to "abort" a writeback request (instead of using fixed timeouts per
>> request). Meaning, when we stumble over a folio that is under writeback
>> on some paths, we would tell fuse to "end writeback now", or "end
>> writeback now if it takes longer than X". Essentially hidden inside
>> folio_wait_writeback().
>>
>> When aborting a request, as I said, we would essentially "end writeback"
>> and mark the folio as dirty again. The interesting thing is likely how
>> to handle user space that wants to process this request right now (stuck
>> in fuse_send_writepage() I assume?), correct?
> 
> This would be fine if the writeback request hasn't been sent yet to
> userspace but if it has and the pages are spliced

Can you point me at the code where that splicing happens?

, then ending
> writeback could lead to memory crashes if the pipebuf buf->page is
> accessed as it's being migrated. When a page/folio is being migrated,
> is there some state set on the page to indicate that it's currently
> under migration?

Unfortunately not really. It should be isolated and locked. So it would 
be a !LRU but locked folio.

-- 
Cheers,

David / dhildenb


