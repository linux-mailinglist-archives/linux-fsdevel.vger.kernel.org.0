Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2534311D960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfLLWcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:32:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730818AbfLLWcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576189941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcJp5d02ffhslABjm0JRL5WxPWI1YxxsBS3tQ0tjUug=;
        b=XDtYfaI74YB1jl9e6Ye8GjQN4x86M+iUMiKEw0sG9mkgX/UDJIEMfeb6VZcJunMMW6T0tl
        gQGfop+00QPxlxipicXXiaFiEDcjgjuhWkcTXJIpyDWkhAa51Vq7NJ1kPtZbPNuWmoI2ev
        HxQAL7iCm17MxW+3+tU+zE0RIakzeSI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-rBN1aHMvOB2tmHDTyDe_qA-1; Thu, 12 Dec 2019 17:32:18 -0500
X-MC-Unique: rBN1aHMvOB2tmHDTyDe_qA-1
Received: by mail-qt1-f198.google.com with SMTP id g22so481467qtr.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 14:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcJp5d02ffhslABjm0JRL5WxPWI1YxxsBS3tQ0tjUug=;
        b=l8urA8WttYys6dPECfB/J1+hQQHxAdgLMHeI7dkFaAeCdTYNkNQVFLoPTOX4dVYwDl
         IafjkX3tF+EIOAxuPP1SB2Rz/Ox4gamP6JgS9s28zSg7s+CaKjtrhIsOHEGRbgwayUrC
         zu7JR+AxO8dQdL0+mf/OCAjE7hn6mMHun0Lptcx+ucOGwV3cZG8qaBLAVzTNlYwsUWBb
         kUrfslJKbDlw+PmxsLrl9ItRhaLNI7+DMjd1rtRqAkS//MEDB10tABSDfysMnLwxSw+d
         DnDF4qxnKU56mk8a157zaCJeVBzPNRY2J3jpF2Lqj06s3xy6c5RqBZui6zcLFpj4oGUY
         PJpw==
X-Gm-Message-State: APjAAAXk4S0VLXwHlBSzgDQguVhkwTtDecw6cIMFkoGp3fOeZwusGE5M
        kVqqOTwh9jWyITur7zaMim9GEFxrbeQt04ZX3ZdpzxLHJ9MR71iuTmZkuq9t0ixzJUNJ4uyohaX
        /6snH2GhKYJ+zG1/cQPZPYFaEBg==
X-Received: by 2002:a0c:acc2:: with SMTP id n2mr10517801qvc.225.1576189937880;
        Thu, 12 Dec 2019 14:32:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPTmOy4ajO0DxlZVi3iwrbQ6XXtLuFR20j6ai74yyPPLB1q/GpEEJj/ZsbDHyyFh1kYXNvbA==
X-Received: by 2002:a0c:acc2:: with SMTP id n2mr10517773qvc.225.1576189937490;
        Thu, 12 Dec 2019 14:32:17 -0800 (PST)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id a24sm2155877qkl.82.2019.12.12.14.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:32:16 -0800 (PST)
Subject: Re: [PATCH] vfs: Handle file systems without ->parse_params better
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
References: <20191212213604.19525-1-labbott@redhat.com>
 <20191212214724.GL4203@ZenIV.linux.org.uk>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <27e4379a-baae-4dbb-1fcf-c4a92fcde341@redhat.com>
Date:   Thu, 12 Dec 2019 17:32:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212214724.GL4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 4:47 PM, Al Viro wrote:
> On Thu, Dec 12, 2019 at 04:36:04PM -0500, Laura Abbott wrote:
>> @@ -141,14 +191,19 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>>   		 */
>>   		return ret;
>>   
>> -	if (fc->ops->parse_param) {
>> -		ret = fc->ops->parse_param(fc, param);
>> -		if (ret != -ENOPARAM)
>> -			return ret;
>> -	}
>> +	parse_param = fc->ops->parse_param;
>> +	if (!parse_param)
>> +		parse_param = fs_generic_parse_param;
>> +
>> +	ret = parse_param(fc, param);
>> +	if (ret != -ENOPARAM)
>> +		return ret;
>>   
>> -	/* If the filesystem doesn't take any arguments, give it the
>> -	 * default handling of source.
>> +	/*
>> +	 * File systems may have a ->parse_param function but rely on
>> +	 * the top level to parse the source function. File systems
>> +	 * may have their own source parsing though so this needs
>> +	 * to come after the call to parse_param above.
>>   	 */
>>   	if (strcmp(param->key, "source") == 0) {
>>   		if (param->type != fs_value_is_string)
>> -- 
>> 2.21.0
> 
> No.  Please, get rid of the boilerplate.  About 80% of that thing
> is an absolutely pointless dance around "but we need that to call
> fs_parse()".  We do *NOT* need to call fs_parse() here.  We do
> not need a struct fs_parameter_description instance.  We do not
> need struct fs_parameter_spec instances.  We do not need a magical
> global constant.  And I'm not entirely convinced that we need
> to make fs_generic_parse_param() default - filesystems that
> want this behaviour can easily ask for it.  A sane default is
> to reject any bogus options.
> 

Well the existing behavior was to silently ignore options by
default so this was an attempt to preserve that behavior for
everything rather than keep hitting user visible bugs. I'd
rather not have to deal this this for each file system.

> I would call it ignore_unknowns_parse_param(), while we are at it.
> 


