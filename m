Return-Path: <linux-fsdevel+bounces-35962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646639DA361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 08:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25262284AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79015575C;
	Wed, 27 Nov 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf+7vW/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7B18E0E;
	Wed, 27 Nov 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694122; cv=none; b=fdFDIJM3ERW8KxZLuOeH4vnL0CTYFt3PV54CRr7VcGGdb/dX16kZpSx7CaPnbAMQFgDxkF7bHPZFZtxJKYJsKXKjsmqNf/NScAtlBc2flp+kpUAiQhg4dWNMbM2plJVQxoFi25EuM6uStwfrBE6D5dnHQqdvIlELYuI3cFkODEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694122; c=relaxed/simple;
	bh=xOk9bVQYlvfAagAJYPtlh5kIoSLygT//cNWYNEnbMQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emA9pKqPuRViwkZdz9HhvfawkA9NK+UVvYjHuIadIibDuKx7XJ5HXmVqiAMQZS8EyISXbpS9IAby7VXngwJ66rOJNkyHGpzh9M1uc4VdeuxPFpli8W1qjQ7QkZhyWqcPcjZ6vho6sfZhwzygcs0Tl+HB5yEI7nPdYLMIrgo+sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf+7vW/n; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df1e063d8so175731e87.3;
        Tue, 26 Nov 2024 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732694116; x=1733298916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGWQ1sChWGYzmBoNIP5bk9GE7YFe+i1tuP3FVoV5U5Y=;
        b=Gf+7vW/nHGQJB7zP+xcbJZ8lBx6Zl4lebArroZZgqSoIEp3yli8ELpqbiV/lSQT5sT
         DFmZgyy3BJQDSiaVAZhPxDUSAOcuAE6juKyoZTF8ODoepIF/l63lHCsSm3sHMOTpm/Rs
         4Mr/loVXTqd7Ibtk7AA1XT5NfNN8awzKrgMRsx0yeN+b0/u53AXg3Kt8xeUgqqq8S64C
         /mbBNcWrVeSWAiWH9sdbgRe9BfCahnvgsh0H6pEvNh3HgXvdASkz5vRqsXh712EGRzJO
         P8Ki5Xy/bZ+LKBveo8D0ThuOuAcRW5aZfz697AjOmOygjXTqP3/DF3u3AP5QWdjP89BN
         MIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694116; x=1733298916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGWQ1sChWGYzmBoNIP5bk9GE7YFe+i1tuP3FVoV5U5Y=;
        b=KnMAgq31GYicgRNlF+ddvrhwImYDwirOgBqgb+/JMusbefTu9Nk9ab4Y7MusMLXXFz
         QGLnAf18UwJO62kDINv5/QRb/P9qzjbAKByPOtztoryNYdhLbvMLg5QCOxqdxpYgTbHE
         9+pnwawgBQ0TVV055H69yn+IsvLXO41UiYVvvikIWa4MFj/jppczK7LX8EBmN1hSJRhc
         SJnpq+Ne+e5cmVaAMrdZDFBQeqOTTaHIt3NTpOIXm+//Z7Yhj8l6F0N4ZIr40lsGlvaG
         SWb1Bwgg5tje27gllmdNTXn3LoGMHQrbNpeY0uRUDouazwF6Db96TBaOTSYfQPD82Zw2
         Ut7g==
X-Forwarded-Encrypted: i=1; AJvYcCUwLYEAF/vzArl4M9bhpEBzR/CjsTJwo9Rb7yAG+xuNkdwRGeM4dF/hm+1t+DoJMPvfo5Q3Cauienr2tW9S@vger.kernel.org, AJvYcCWw+jLfLBj6VTG/rdhmv+rzxluBN+GSJIkUgx9pkXpi8E2QDB/UFnISmHPTtDoPG6ixfFHc6jkCxew6/3AJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg30Td63mXjOTePvyQIopYkSVuoINFZIOwqTkjZDkg2OSU41dM
	E+aaSvOnGzWHGoc4Vk4prik6brb2CJnM+GJk08WpRH3gtyaaWtyx
X-Gm-Gg: ASbGncsMHa2hyLrCLkZzRgM98hTStELYcGsf4Pnc+kBVMWfAodx8aSPGeMqKQvsdslx
	Pp8+7tNLsiicedA7hDhNOwZrXK4XdxtxsdGsIc+lZoptS6T1b9pLIQ/GHsjy/A1GFXPepVDLatP
	xnxsu3lA+XOEaqXvhg+fJeciDtnxSygxcOaIaqGr9/e8+V20uUp/YbPJRyQrhlg+VuH6DC8jYb8
	LarZmnF4zPTsjxjgFqfz3GJ/XZ9TzY4/wz2MpyQRav5+v+8PWGXfS4bKmIE0SxfPxQvnNmEuAE6
	tey5GWEQ
X-Google-Smtp-Source: AGHT+IEbbPe1I6HmGXbu5iMcKg85RnC3++SP4n4FvFu2rBZ9au0a2KeUhuG+RffetELROIKre6q4kA==
X-Received: by 2002:a05:6512:3a8c:b0:53d:e5fc:83c8 with SMTP id 2adb3069b0e04-53df0104707mr1023581e87.45.1732694115897;
        Tue, 26 Nov 2024 23:55:15 -0800 (PST)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53de0c3ce8bsm1241799e87.116.2024.11.26.23.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:55:14 -0800 (PST)
Message-ID: <6d4cfb7b-b1c4-4307-a090-c5fd0b895a7b@gmail.com>
Date: Wed, 27 Nov 2024 08:55:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in NFS probably due to very large amounts of readahead
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Philippe Troin <phil@fifi.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <20241126150613.a4b57y2qmolapsuc@quack3>
 <fba6bc0c-2ea8-467c-b7ea-8810c9e13b84@gmail.com>
 <Z0X9hnjBEWXcVms-@casper.infradead.org>
 <569d0df0-71d5-4227-aa28-e57cd60bc9f1@gmail.com>
 <Z0YWrvnz5rYcYrjV@casper.infradead.org>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <Z0YWrvnz5rYcYrjV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-11-26 19:42, Matthew Wilcox wrote:
> On Tue, Nov 26, 2024 at 06:26:13PM +0100, Anders Blomdell wrote:
>> On 2024-11-26 17:55, Matthew Wilcox wrote:
>>> On Tue, Nov 26, 2024 at 04:28:04PM +0100, Anders Blomdell wrote:
>>>> On 2024-11-26 16:06, Jan Kara wrote:
>>>>> Hum, checking the history the update of ra->size has been added by Neil two
>>>>> years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
>>>>> process all pages"). Neil, the changelog seems as there was some real
>>>>> motivation behind updating of ra->size in read_pages(). What was it? Now I
>>>>> somewhat disagree with reducing ra->size in read_pages() because it seems
>>>>> like a wrong place to do that and if we do need something like that,
>>>>> readahead window sizing logic should rather be changed to take that into
>>>>> account? But it all depends on what was the real rationale behind reducing
>>>>> ra->size in read_pages()...
>>>>
>>>> My (rather limited) understanding of the patch is that it was intended to read those pages
>>>> that didn't get read because the allocation of a bigger folio failed, while not redoing what
>>>> readpages already did; how it was actually going to accomplish that is still unclear to me,
>>>> but I even don't even quite understand the comment...
>>>>
>>>> 	/*
>>>> 	 * If there were already pages in the page cache, then we may have
>>>> 	 * left some gaps.  Let the regular readahead code take care of this
>>>> 	 * situation.
>>>> 	 */
>>>>
>>>> the reason for an unchanged async_size is also beyond my understanding.
>>>
>>> This isn't because we couldn't allocate a folio, this is when we
>>> allocated folios, tried to read them and we failed to submit the I/O.
>>> This is a pretty rare occurrence under normal conditions.
>>
>> I beg to differ, the code is reached when there is
>> no folio support or ra->size < 4 (not considered in
>> this discussion) or falling throug when !err, err
>> is set by:
>>
>>          err = ra_alloc_folio(ractl, index, mark, order, gfp);
>>                  if (err)
>>                          break;
>>
>> isn't the reading done by:
>>
>>          read_pages(ractl);
>>
>> which does not set err!
> 
> You're misunderstanding.  Yes, read_pages() is called when we fail to
> allocate a fresh folio; either because there's already one in the
> page cache, or because -ENOMEM (or if we raced to install one), but
> it's also called when all folios are normally allocated.  Here:
> 
>          /*
>           * Now start the IO.  We ignore I/O errors - if the folio is not
>           * uptodate then the caller will launch read_folio again, and
>           * will then handle the error.
>           */
>          read_pages(ractl);
> 
> So at the point that read_pages() is called, all folios that ractl
> describes are present in the page cache, locked and !uptodate.
> 
> After calling aops->readahead() in read_pages(), most filesystems will
> have consumed all folios described by ractl.  It seems that NFS is
> choosing not to submit some folios, so rather than leave them sitting
> around in the page cache, Neil decided that we should remove them from
> the page cache.
More like me not reading the comments properly, sorry. What I thought I
said, was that the problematic code in the call to do_page_cache_ra was
reached when the folio alloction returned an error. Sorry for not being
clear, and thanks for your patience.

/Anders


