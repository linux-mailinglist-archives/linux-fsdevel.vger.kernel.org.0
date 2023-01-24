Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F64679934
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjAXNXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjAXNX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:23:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61210DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674566561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjerv6eeHIr3bHdYRBICxRPy+uiogP5njwQF0TsOBK4=;
        b=g15FeD5M2KdtxNF+b5odGOhZNuk7oqKubYzEVusb/f0GZDmROpx+/5zk9yz6wOa8rpbLfU
        RCtIGg2bBblBL+d6ILynmhv0lkEpF37Bb57uIRaV7F1P5+wuc4nXNnNtq11eGknIH2OJ9u
        l9BAolornqXz4Q21SNAdWotpwtaWgoc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-5Ol7YD6OM1eqbkygglkDNg-1; Tue, 24 Jan 2023 08:22:40 -0500
X-MC-Unique: 5Ol7YD6OM1eqbkygglkDNg-1
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adfe4cf000000b002bf9413bc50so1786830wrm.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjerv6eeHIr3bHdYRBICxRPy+uiogP5njwQF0TsOBK4=;
        b=Mpi1RXYAu3eC/sIDcTHbXc4RoFnk1/uvVr/DtHnZ23NX68BH9OAeHx4+Q/bj+bJ7Nt
         QxE+uk2JM+StqGOqhodFpkW7VUnl8DhwwWEg4QY4GutG/7PV7sU+RrBnnMoQjt6VZF3d
         OwIoL9tLMSknYgUulvzo9hoCtHpnnIp3UYWzcKGqBNMQZMTjjjv1x/6jzIXnZ+5EG02h
         x2Z1aIUPPm5KB4wINTcQ+zdJ0nkxu2oEjQuwJKOv0p0dFgW5gLNR9kxUhqDxIquN9B34
         Yvf+736MXEK0phiWzEJrF0IYMInQ7gHhscZxnJk8Q384/AiRI60OonqWBHqMw7IENwRk
         vEdQ==
X-Gm-Message-State: AFqh2kpxR+3Q2MAKsBW77ebJ3oXStunjVPnraj26VeAbttjpr1fbdmbI
        JgANc6z7+0OvEK/9OYw7nP5VQpZI3Dpdv0QKI9+F0jNIYOo7v0prNhbbWZn5PT8Ir+VzVILkbSD
        hz1msolRsqj7oAqJsAbhBFXjAWQ==
X-Received: by 2002:a05:6000:128f:b0:2bf:9527:ce66 with SMTP id f15-20020a056000128f00b002bf9527ce66mr13053799wrx.26.1674566558985;
        Tue, 24 Jan 2023 05:22:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRjqYILWW29/H2/hFHyUqXFadYiafSdxG+px47OMrS5yg4OlcjT3QyzUClycBmvKQ5FUt6Yg==
X-Received: by 2002:a05:6000:128f:b0:2bf:9527:ce66 with SMTP id f15-20020a056000128f00b002bf9527ce66mr13053787wrx.26.1674566558728;
        Tue, 24 Jan 2023 05:22:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d4408000000b002b8fe58d6desm1867622wrq.62.2023.01.24.05.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:22:38 -0800 (PST)
Message-ID: <0c043cfb-2cdb-8363-2423-d1510006fc06@redhat.com>
Date:   Tue, 24 Jan 2023 14:22:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123173007.325544-1-dhowells@redhat.com>
 <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
 <Y8/aSZBVVF7NpDQ0@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8/aSZBVVF7NpDQ0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.01.23 14:16, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 01:44:21PM +0100, David Hildenbrand wrote:
>> Once landed upstream, if we feel confident enough (I tend to), we could
>> adjust the open() man page to state that O_DIRECT can now be run
>> concurrently with fork(). Especially, the following documentation might be
>> adjusted:
> 
> Note that while these series coverts the two most commonly used
> O_DIRECT implementations, there are various others ones that do not
> pin the pages yet.

Thanks for the info ... I assume these are then for other filesystems, 
right? (such that we could adjust the tests to exercise these as well)

... do we have a list (or is it easy to make one)? :)

-- 
Thanks,

David / dhildenb

