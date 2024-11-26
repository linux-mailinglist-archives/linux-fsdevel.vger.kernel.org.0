Return-Path: <linux-fsdevel+bounces-35932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68239D9C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B88B280567
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731711DCB2D;
	Tue, 26 Nov 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR7nF6ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3911DC198;
	Tue, 26 Nov 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641981; cv=none; b=MaXKJlyELbrZa82F5WJfTaBb7UkktaMSUARBscmrxjqZKYWk//c9YzWtzj50JZ+Aj0gctyoQ0uKMusIeiIvSURC7xntpFfsM+VONkI84XXl3Xl2zyRgDjPO+F7UY18+T5O+uwon8rnEji92WJ+MeZe4yIvqezUF7GofJtfwbOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641981; c=relaxed/simple;
	bh=uuol9S7Wb+mpmGwMh8nS26lktMF+KT82jsiXhvL+wAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTye5Wf2SkDj36+j6JXrOYz1WelQFPQwTd7ACaJS3dvOqS5d3hpy7+nB0mNzcW2hh//RSQ99BOU5rOSMGlPqkV3rDjASaVY5QF7mRemyzOanVZ7j4nB1pequJ/l3UDoh6XhEdyXkubq2koh+1qJ39/wivyrMxUkCKnRd9jJKTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR7nF6ns; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so5371941e87.3;
        Tue, 26 Nov 2024 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641978; x=1733246778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbotIOfnAlUpiXN0cwY6JBmQStHByFNUpy3SVfR48QQ=;
        b=aR7nF6ns5pj0kr/3V4W3V1jJBNeJQ2N8gEFfZdPajNJFet4fpkFSeZqKcB/GhgsOPO
         d6FH7EHEQ5ztzwOXHwmvZxPzfFicAc45DNLaJ+55Y1fNEYnfrvxIm544waCCJva8eVmF
         adp8MIfaqaxhEo9NQPJqbsF4GrigUz7uuuNi9CWnaX0WcijPVlFf2zcJ/vmcrl8LWcTm
         HFwoTJv5OUGpFHd2vR2PWDkaHU5TBnrkcBYlrZqMy2r+ApPnFhm/4yEtgSoy6zjuwqCl
         WeZLR7j1Izz7CkOgLQqpqCvQqUtvLIYWRZCGkeoY8mSYlhE1g1163eRhwqhSv3wq5RjR
         xmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641978; x=1733246778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbotIOfnAlUpiXN0cwY6JBmQStHByFNUpy3SVfR48QQ=;
        b=XRyWzSihtkHHO3D+VZdkaJDwE4IlJFxq5YQz+1jnfj4XSQUTEsXEDpdzlwBxpUcyVl
         YvoXUkB+ECZ3fSTmmMi2e8/ncAfM50l1A8/UCNICMkhDvDNwZVLNeNgwUV9dw8hF+U8U
         dFVqJ9Blbkt5kPoYciwuZWeG+AiU81TujMbUnTxWsFEAA29rzWzHJZpQZdJbaFEjvi/c
         /g4ZJt4WkkyhjY8gtfTr2jI5hlna3M7OAljPpLQE6OXTP+tfB0/xKq3guJzaWuE+YRhc
         W85h2X4rjptuGGB4GhLf4qE/w3fTXrIsd8ZCRh3uUzgXfq8K6xfg8S4CVG9gFtFAJaaw
         gDDg==
X-Forwarded-Encrypted: i=1; AJvYcCV1G5OgqtEYVSxdaG2kXZ4sYoTBSv1hqRXJ/lbZjIWdyHrx1DpRB7J9JNUC8w+/0/zk0JnHPWEXwsGJLRcJ@vger.kernel.org, AJvYcCV3m+JKnzqr3UNbz0JDiLTbqpVcnA6gOHyscoGWe3Kxr4NyAkTBYmPNDg+okvrMS8JpWmqNasuLLYSoQvyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbm8OJHPTO5HF4Dou+2ayxsq3+zLbDOhhQ2ydbwu42uc3JOgD
	O0+kOy0sRuSoTO52Hx3yWGi6K4ZbY0GS0PbOqQ8Kc+4ypgUocRbW
X-Gm-Gg: ASbGncuITVfvzWqsBbdR8j1zjChS/76posLhPJD8pFNs0XNDyyeqW2ndzWL5NOMgBOW
	NgFRN4xNDOcZVCntM0whLhAGBVZACkP4DwE5UrwOTT8/w9EklLhk0n1V0SVVko8SL8BHXZNEi/t
	q/q47DCnAGsC26iXbrB9mRv7onoFImXyuvZtwC/pPrfWKYcLb+sgSsku0IRXVbHxopOdTMteUkQ
	m1tYbht1cotQEtzn+UsOMMBVgMva3Mp9qNGTIoGWopgYFxVVKuScfp7UX2llhcGUDW2FtNFG9b6
	rxbGfI8yK9BV2VBcPe+sgyJU
X-Google-Smtp-Source: AGHT+IEtv4oFJfiSacSbN3zNtp7opyl3x9b+XbgiIuNfyCw+fad4RwfteGd/8dhj4mLs9xnvqQ2raQ==
X-Received: by 2002:a05:6512:3052:b0:53d:edf6:96e2 with SMTP id 2adb3069b0e04-53dedf697d4mr903126e87.11.1732641978019;
        Tue, 26 Nov 2024 09:26:18 -0800 (PST)
Received: from ?IPV6:2a00:801:2f0:b124:4cc6:80e8:d57e:220? ([2a00:801:2f0:b124:4cc6:80e8:d57e:220])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451a3csm2052062e87.82.2024.11.26.09.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 09:26:16 -0800 (PST)
Message-ID: <569d0df0-71d5-4227-aa28-e57cd60bc9f1@gmail.com>
Date: Tue, 26 Nov 2024 18:26:13 +0100
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
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <Z0X9hnjBEWXcVms-@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-11-26 17:55, Matthew Wilcox wrote:
> On Tue, Nov 26, 2024 at 04:28:04PM +0100, Anders Blomdell wrote:
>> On 2024-11-26 16:06, Jan Kara wrote:
>>> Hum, checking the history the update of ra->size has been added by Neil two
>>> years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
>>> process all pages"). Neil, the changelog seems as there was some real
>>> motivation behind updating of ra->size in read_pages(). What was it? Now I
>>> somewhat disagree with reducing ra->size in read_pages() because it seems
>>> like a wrong place to do that and if we do need something like that,
>>> readahead window sizing logic should rather be changed to take that into
>>> account? But it all depends on what was the real rationale behind reducing
>>> ra->size in read_pages()...
>>
>> My (rather limited) understanding of the patch is that it was intended to read those pages
>> that didn't get read because the allocation of a bigger folio failed, while not redoing what
>> readpages already did; how it was actually going to accomplish that is still unclear to me,
>> but I even don't even quite understand the comment...
>>
>> 	/*
>> 	 * If there were already pages in the page cache, then we may have
>> 	 * left some gaps.  Let the regular readahead code take care of this
>> 	 * situation.
>> 	 */
>>
>> the reason for an unchanged async_size is also beyond my understanding.
> 
> This isn't because we couldn't allocate a folio, this is when we
> allocated folios, tried to read them and we failed to submit the I/O.
> This is a pretty rare occurrence under normal conditions.

I beg to differ, the code is reached when there is
no folio support or ra->size < 4 (not considered in
this discussion) or falling throug when !err, err
is set by:

         err = ra_alloc_folio(ractl, index, mark, order, gfp);
                 if (err)
                         break;

isn't the reading done by:

         read_pages(ractl);

which does not set err!

/Anders

