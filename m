Return-Path: <linux-fsdevel+bounces-70394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17642C99648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6824E2037
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A92853F8;
	Mon,  1 Dec 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXopGXC1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeLUb4Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A124E4C3
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628626; cv=none; b=I5SaxUrq8z0OSTIHTrH7T0mWW1r24/aJq+mVXqN3kqOHsw80fC0mKuOiEAWkA7hYgDl4Y0DMuod/l3VzD07XoKC58mCwxbkTgrMDi8bFOQjFjOz8c83fUo+SOMKQQAgwr4G43QQ5rVxKiKA7gDJ1p9+ZOc/HW73+v2tSNEiWnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628626; c=relaxed/simple;
	bh=1YTmjXiDfWT06ovBh9wfUTGqRkMz4rOaoeTg+gBuuh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJd3W2mEC0BR8Hz4lQuT5CoWU771QYpx+eUQVWep4ml1XC6yTH4l5AoKUVDGqp76bIY/tfm6J+P9gn2tY8nCM6cWC1AHa1+9UdEUP1WKquCjk7ArNUTCpi+/OPjbmOpGH0SBwSbIH6WLvkmYm20M8espOyO3dfDeKMb/2wEWWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXopGXC1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeLUb4Yc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764628623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9W8GtlmMztPOKGmNDt/1BWnxRfhcYHphKSMv+Jfars=;
	b=VXopGXC1GLKeBlOoehIgeVKi/K/wqYdPuNCeb2TsHWMpKrY2pSDxPNsPASsDqoKEozaSnV
	oy6CXzkbO+lf9prQ0ynI+E6UOHtjp+6WgUDivyxMEGMI8HI8+DX9dAg5hxMErWRuPzeEWA
	lh5OWg1N3Eox7qsf8Qga/DLoFYGkHvw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Sc8HUWV3N3ykIBL-Pxvf-Q-1; Mon, 01 Dec 2025 17:37:02 -0500
X-MC-Unique: Sc8HUWV3N3ykIBL-Pxvf-Q-1
X-Mimecast-MFC-AGG-ID: Sc8HUWV3N3ykIBL-Pxvf-Q_1764628621
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c70546acd9so10132453a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764628621; x=1765233421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9W8GtlmMztPOKGmNDt/1BWnxRfhcYHphKSMv+Jfars=;
        b=IeLUb4YcxTY2YjE9h3OyUizqPtFI1cZL5WUefYLqAG7oxYHpMaYMpgmweN9BLn4KUY
         160csxwD8AXj6NwY8RC73hhz/mOYfHfe/m7JeS6MlgJFOF7rWNGa6RR+avP7B5eEMOX2
         xz3/IkK6vFE5kUTEbKE6TYr7rH0RB4O4PepOb63WNO+ol3IRY55VWzGU+D0IrKnZKOSG
         iuwqrStfZ+yAbU/92h4ssoFq4FmhDqLkbWO/c8/pob/zXjc0PAgtjchwyr8zXSV2DGD6
         eKuO2AW77xCh8zopt3Dc4aY2mjl1333X3fE3evO7pL7oK442WrtI6frxoCV7rSqLpvJM
         nRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764628621; x=1765233421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9W8GtlmMztPOKGmNDt/1BWnxRfhcYHphKSMv+Jfars=;
        b=lica6D+4/p4rihIpvfXE8YD1Y+1wVDeRIvFfS6HCqduABaVoJau+Kh1gNJMntrITTr
         d5yhf/acAxL8bp1nBSeLQClAwnDklX0EvfGo9g4vjueg9jfgD2K3Fma3d1AL7amQRI0e
         OReAuIOY5KPycjM7qcEUfHWfTYS1LTPPPbS5ajJXnfKmA16HQhz3E/YWgUqRNsMzj0+M
         5evPpZZGgDR6UUA7obwpActymHmZv8Qz3vZae0gaS46EUUHx2ZHXktIhi2Dx45mbusP2
         FuLWCU/QqD2/5f7rQj/u/KGA3LwY0Gz5waV9EMaNq0QGGhhuU2ZXqno7tDSFwBE/MsRg
         1rqA==
X-Forwarded-Encrypted: i=1; AJvYcCU02o+XVB1izAOpFU9WW/DF3lt89pecuIiK81iTyb7G8htEr8Hxe8X60lew4oD3QwuJVqhdbW1fRvMBQwzL@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBUgt1fauApMWjGz3+0+FeaaybOtpp5oIstNdzbUyHR6fdIJB
	bEkXsIWG3Uroti4Vku4bn/iutJ3dtVkEd7s+4kL3OhrM6W82dLcV5+ohNN5gBOvldWjsExPqdFy
	sMpDk+R8vHcLB1JIg0RdQBaZRLwfW4/Ak17mBAJ6/KNZTw0DQA74sjP3CaF+lEmP4e38i+SKz+v
	o=
X-Gm-Gg: ASbGncuXlP5EOTeSpz6fhAY8nrx+rSj3z7DG1C2hGvT/lMm9WBKVBYItY+0DoE0bT2Q
	hGQm+tplTy03gChNQH3VnlFwQPsME61MGENogu2T1VlMjlGRQWXNhzOagILOFswrcEEsn0AcfRl
	1oMmF1i7g4G+XuiOChT3/Mf4IQIjePPtAK3TueEMwOHVcl/jBOCKbaaR7TtkUPHHt+4aDmBETpM
	IE4pc1mLcwRHVG4gC/5eSH8oRVbFKy2EvoXTR+beuVu3wlqpaWNH1A4usGkL1+DUs0vY8gVmom6
	Bl6b1SBr6g+k8Ir46jGv0BCMZD0wyX28/hsCUVz0LYyMZdSlRezxj0YMM59SHrdEf2Lr2JgUzT1
	0UnaFKNQwxh1SIxqiF7Zd68vhrO3y2YwusIYBl5/zQkkcJHJvo0A=
X-Received: by 2002:a05:6830:4424:b0:78a:8b0d:cd54 with SMTP id 46e09a7af769-7c7c445d9dcmr15820499a34.34.1764628621156;
        Mon, 01 Dec 2025 14:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnZLeXtAHqL1HJaAkrrfYrqLSObw8oU2jukj6wTDOBEtDA/eVqZfK5ZNe81bHUoAj3Cj83nQ==
X-Received: by 2002:a05:6830:4424:b0:78a:8b0d:cd54 with SMTP id 46e09a7af769-7c7c445d9dcmr15820472a34.34.1764628620708;
        Mon, 01 Dec 2025 14:37:00 -0800 (PST)
Received: from [10.0.0.82] (97-127-77-149.mpls.qwest.net. [97.127.77.149])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0be23sm5341133a34.21.2025.12.01.14.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 14:37:00 -0800 (PST)
Message-ID: <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
Date: Mon, 1 Dec 2025 16:36:58 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, eadavis@qq.com
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aSeCdir21ZkvXJxr@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 4:43 PM, Dominique Martinet wrote:
> Hi Remi,
> 
> Remi Pommarel wrote on Wed, Nov 26, 2025 at 09:16:14PM +0100:
>> While testing this series to mount a QEMU's 9p directory with
>> trans=virtio, I encountered a few issues. The same fix as above was
>> necessary, but further regressions were also observed.
> 
> Thanks for testing!
> (FWIW that patch has been rolled into my 9p-next branch, so you shouldn't
> have needed to fiddle with it if using linux-next)
> 
>> Previously, using msize=2048k would silently fail to parse the option,
>> but the mount would still proceed. With this series, the parsing error
>> now prevents the mount entirely. While I prefer the new behavior, I know
>> there is a strict rule to not break userspace, so are we not breaking
>> userspace here?
> 
> That's a good question, we had the same discussion about unknown options
> which were causing errors in the previous version of this patch.
> 
> My personal opinion is that given it's easy enough to notice/fix and it
> points at something that's obviously wrong, I think such breakage is a
> necessary evil and are occasionally ok -- but it should be intentional,
> so let's add some fallback for this version and we can make this break
> at the same time as we make unknown options break
> 
>> Another more important issue is that I was not able to successfully
>> mount a 9p as rootfs with the command line below:
>>  'root=/dev/root rw rootfstype=9p rootflags=trans=virtio,cache=loose'
>>
>> The issue arises because init systems typically remount root as
>> read-only (mount -oremount,ro /). This process retrieves the current
>> mount options via v9fs_show_options(), then attempts to remount with
>> those options plus ro. However, v9fs_show_options() formats the cache
>> option as an integer but v9fs_parse_param() expect cache option to be
>> a string (fsparam_enum) causing remount to fail.

Sorry, I was out for the US holiday and just getting to this.

So previously, for cache mode we expected a string for the mount option,
converted that string to the numeric value via get_cache_mode(), and
v9fs_show_options displayed that cache mode value  as hexadecimal, right?

        if (v9ses->cache)
                seq_printf(m, ",cache=%x", v9ses->cache);

Oh, I see - the last "if" in get_cache_mode() accepted the bare numeric value.

>> The patch below fix the
>> issue for the cache option, but pretty sure all fsparam_enum options
>> should be fixed.
> 
> Oww. That's a bit more annoying, yes...
> 
>> However same question as above arise with this patch. Previously cat
>> /proc/mounts would format cache as an hexadecimal value while now it is
>> the enum value name string. Would this be considered userspace
>> breakage?
> 
> Now these are most likely ok, it already changed when Eric (VH) made it
> display caches as hex a while ago, I wouldn't fuss too much about it.
> 
> OTOH if the old code worked I assume it parsed the hex values too, so
> that might be what we ought to do? Or was it just ignored?

Looks like it accepted either the string or the hex value, so that's my
mistake.

I suppose it would be a terrible hack to just extend the enum to include
hexadecimal "strings" like this, right.... ;)

+static const struct constant_table p9_cache_mode[] = {
+	{ "loose",	CACHE_SC_LOOSE },
+	{ "0b00000000",	CACHE_SC_LOOSE },
+	{ "fscache",	CACHE_SC_FSCACHE },
+	{ "0b10001111",	CACHE_SC_FSCACHE },
...
+	{}

I think the right approach would be to just reinstate get_cache_mode() to
do open-coded parsing as before, and get rid of the enum for the cache
option.

Would you like me to send a patch 5/4, or an updated 4/4 to implement this,
or would you rather do it yourself if you think you have a better chance
of getting it right than I do?

As for the other enum, I think we're still ok (though maybe you can confirm)
because p9_show_client_options() still does a switch on clnt->proto_version,
and outputs the appropriate mount option string.

-Eric 

> I'll try to find some time to play with this and let's send a patch
> before the merge window coming in fast... This was due for next
> week-ish!


