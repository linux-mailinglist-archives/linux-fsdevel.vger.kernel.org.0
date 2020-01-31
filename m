Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84DF14EA43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 10:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgAaJwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 04:52:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40447 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaJwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:52:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so4430903lfi.7;
        Fri, 31 Jan 2020 01:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2zLinx65kFK53ILK1AcLmmd59Fu+8auTjozCt4FuyXc=;
        b=tFa2xXLPMfbQa4Lg+mSI8s/TlT4TEzvbjICetoMKNxdwsGqzYXd99yW1obFpVYoOS4
         f8Gbz5MIV2/PXrL+s/pjZtrbShpOtC2tKv+BLM5WSbYiBfTxAXxn5fa9/SyBtl5oHAdE
         OSnzwoFVXEhFweNJQ0O0/gS3uMzcAgcfrEOJ5Czh3qv4KSoxVWzGDiNr/QV1Ne4UJ+n8
         1WSiDCeF31WdwWWjWg9C1Q9fYze+ZMMgpDo1L3z0c/izJuNZw6VnInN3LoxbA8yeEWMp
         RTIt6xMq7wgtger92/GnJMXCeje8Cv1s+uiRxVEaDF/U2VIWd0T1AzS667H57mwt6iwn
         VrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2zLinx65kFK53ILK1AcLmmd59Fu+8auTjozCt4FuyXc=;
        b=Bynxe7cbs/20JuuUp/Bv7LvTnz6LOS+Z+YSR04hwl5gQSi1uDI3vIsocRiBZK2nfUK
         a/2nKKLzb/xlwlFQKmhZqSJw0uW96ITbWZQ/58FbXFkT/c7K3YU4gx3sM/sHPeQaQoE8
         bR+7lqg0teRZE8XTpKy4Bd44Ae0SdtzhHcd6Wh3lu9be1OhnIwySoXJ6kyuJgK92uHvU
         wD/xqzA/fFcq6TYnAbjDZnj6qi6J4CwEMEStbONUfWt3N9/Y2gXY0a9ute6qc2OPacZi
         LF7xW05e0LTG0WmPqE/IZGC0ChDgeWRymxYBSJJNQ8RtRtEYUo94Y8AY4SJZtRJw0AkX
         Vv+Q==
X-Gm-Message-State: APjAAAXiWlKvqW5C1yQKi6GQjmuZioaj3Lu9kjAXsBBUO9Nt4RX0+oeh
        /dIHt9dmCxTKC+8eVFklCBilCMdUmfo=
X-Google-Smtp-Source: APXvYqzYXjb3R9IBvegkSpqNYMQIIrmty+2pa0JXh83XjZcPtPYUYfTGQjgzU3IyYAFO0mtvD25YyA==
X-Received: by 2002:a19:9d0:: with SMTP id 199mr5092184lfj.110.1580464349406;
        Fri, 31 Jan 2020 01:52:29 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id p9sm4380158ljg.55.2020.01.31.01.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:52:28 -0800 (PST)
Subject: Re: [PATCH] splice: direct call for default_file_splice*()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <12375b7baa741f0596d54eafc6b1cfd2489dd65a.1579553271.git.asml.silence@gmail.com>
 <20200130165425.GA8872@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <239aacf6-5f8b-39f4-b4f0-e22de4c46b88@gmail.com>
Date:   Fri, 31 Jan 2020 12:52:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200130165425.GA8872@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/30/2020 7:54 PM, Christoph Hellwig wrote:
> On Mon, Jan 20, 2020 at 11:49:46PM +0300, Pavel Begunkov wrote:
>> Indirect calls could be very expensive nowadays, so try to use direct calls
>> whenever possible.
> 
> ... and independent of that your new version is much shorter and easier
> to read.  But it could be improved a tiny little bit further:
> 
>>  	if (out->f_op->splice_write)
>> -		splice_write = out->f_op->splice_write;
>> +		return out->f_op->splice_write(pipe, out, ppos, len, flags);
>>  	else
>> -		splice_write = default_file_splice_write;
>> -
>> -	return splice_write(pipe, out, ppos, len, flags);
>> +		return default_file_splice_write(pipe, out, ppos, len, flags);
> 
> No need for the else after an return.

It generates identical binary. For this to not look sloppy, I'd add new
line between, so the same 4 lines. And this looks better for me, but
that's rather subjective.

I don't think it's worth of changing. What's the benefit?

> 
>>  	if (in->f_op->splice_read)
>> -		splice_read = in->f_op->splice_read;
>> +		return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>  	else
>> -		splice_read = default_file_splice_read;
>> -
>> -	return splice_read(in, ppos, pipe, len, flags);
>> +		return default_file_splice_read(in, ppos, pipe, len, flags);
> 
> Same here.
> 

-- 
Pavel Begunkov
