Return-Path: <linux-fsdevel+bounces-16730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46928A1E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F81A288259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74047A6C;
	Thu, 11 Apr 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnGURPtu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CB4502A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858684; cv=none; b=F3V6q5BT3Bair4vBARR9wDLab5Ky3lgaZ+rLkY7uScZqB/fgmvP0dMv6C6WUZLz8MT2Ev/zy9mDxIr7ck8y2xB19hjXdvfQ5S4iZXfPzPnHqlU8jxbCEpWvNTUWxmlkrgPTf1AG+8l+D0CbQGvV7VA8H8bzvVaa+pt/41Ph/Akk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858684; c=relaxed/simple;
	bh=PWnjSbvGhhlbyYHaDQxRSBhJ5yILUieF14Y/8x7tt1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHHzIwc8H8pkkFOJ0u/piCRrEf7MZ4YuwBjpmyUWoowevnSQBSNixlu1oOpfjkNzgdwL6SyuNJK01DAtKxaOzZ+VubSmaTtnZlpN5GDtTyav+7wRaga+221Y3Cqw1qNXFcsU1pFV7le4CGhnX+XXEz3QFpj2fqJMYGbcpoyIIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnGURPtu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712858682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpKoRsTU/c/NooRPQViF7RjQEu5sU/PzB15oM6zeiGM=;
	b=VnGURPtukbMzO0OSEJ2PJnoSzZaN62o7HNCrHPN3n71r7dNfHCspQWkM1N1nifQ2jQ3W7G
	/V00MPovEvJk/CO6CTTo28OpmBp8TBfJhAtcyHczsvJIbcmzjmds9yVW/B3c3Ruio+1rm3
	NDok0IMnZnMYigM/LncVDK9Dt0ObYOQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-em5AdK_vMY-bhN99KiaBHg-1; Thu, 11 Apr 2024 14:04:40 -0400
X-MC-Unique: em5AdK_vMY-bhN99KiaBHg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2c3543b85so67301a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858679; x=1713463479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpKoRsTU/c/NooRPQViF7RjQEu5sU/PzB15oM6zeiGM=;
        b=ZCdxOP6MLes+RzSFdD71V3utATLHmkxRgQv4wzxzPToXOH3/Iw/QTQ9LwOimQNp5DG
         J59SGkFT70rwhwn18MBml3RENQifU14c5Sjmoa/IzRpAKLHsxS1pNnO+HXCw3kBBmzrP
         ArJlgW9dsB3DrAXym7t2XxzK/eYjBucd+9PXCqAnUW1EspgKJVXiuqHCy3LJAoJc7K3p
         l5p2viGX5gEPv+UcPjcTyRfIaxYv+5S1qslXxQ9OdEZcUGTTfSUR8zbm0/CYh+NyCgJM
         5oAuV/oUn6GcIJl6qesHT24XvANfBfC3CbzGWcI4bui2VmBKx3wFd5vFjXboeLMoCt8M
         AnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZwBzfh6nzpO1J9tPTCoGwv2xsAv2LVW5tyJAJOuNqwpGe/6qxwG1nBnFWCcVx0FTaHYgTIuykEOyHHD574YjNJ4chFlmcyzWUNHSbQ==
X-Gm-Message-State: AOJu0YybSPpb3yuRySs1os89bKzQcKbBJ2wRG8fU62gjM6Xmlq+TPBoj
	gBeWdDyt8fUiiGaWP/ADSgOcF7v1HQbrvzbqcAJh78psTZ1DUpuVljNIYWW+q9tVQvvRpuIRpr5
	YtGgsJsKlRj15fvFfLdQzbsuV4RWuf16IMAwIUUyimGOAM0kXcT5sy/SIPmTOvdA=
X-Received: by 2002:a17:90a:be16:b0:29d:dd50:afe with SMTP id a22-20020a17090abe1600b0029ddd500afemr281396pjs.30.1712858679614;
        Thu, 11 Apr 2024 11:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8SxSt4ZqtyVm5bwPyxXKm5Y9LmERV9nLCUAxS9fL8uUPRvmXhhMb7PEAXWVfVp2aUxCLc7g==
X-Received: by 2002:a17:90a:be16:b0:29d:dd50:afe with SMTP id a22-20020a17090abe1600b0029ddd500afemr281363pjs.30.1712858679162;
        Thu, 11 Apr 2024 11:04:39 -0700 (PDT)
Received: from [192.168.1.165] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id s9-20020ad45249000000b0069b1ef5d425sm1232834qvq.134.2024.04.11.11.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 11:04:38 -0700 (PDT)
Message-ID: <87cf3851-b419-a83d-436f-2b23451f07df@redhat.com>
Date: Thu, 11 Apr 2024 14:04:37 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/11] dm-vdo: use bdev_nr_bytes(bdev) instead of
 i_size_read(bdev->bd_inode)
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
 axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
 <20240411145346.2516848-9-viro@zeniv.linux.org.uk>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20240411145346.2516848-9-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 10:53, Al Viro wrote:
> going to be faster, actually - shift is cheaper than dereference...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Matthew Sakai <msakai@redhat.com>


