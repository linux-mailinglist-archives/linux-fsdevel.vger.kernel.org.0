Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2E1AF202
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDRQC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 12:02:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36541 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDRQC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 12:02:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id o185so2208141pgo.3;
        Sat, 18 Apr 2020 09:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dj8lEaoE6e4YhmuN/RNuMwlwOm9tt21HvHz1R+SzXXY=;
        b=dDQXYrE1uk6syZEhiM6M62d4BDY2cGcHr5TqES3FFYw86hMxwh6UyC9y9yvaXIqAo2
         /4TLNvPTEOsEpa/EkTsTDcnup29fu7gjeyNTE4BAyv3uMzyPJSA4tHQHcG7fhseZoFHW
         Qb34a8OYzoeevAwxTRXlRdQByIkqhbVEBIuYNGbBPwlRlg8MAkzLMv/vu/h6BkSNxWA8
         tB1ETC1MRFDL/SQIQSsV41jwyesYUrifv24GkZwKBopZEFedvAfRHesv+QgSgzl0u7Ju
         1gDm6+ZaaSL3mbJ9gq8IkIW5e5vxbBDgShPRGm/0GDdFknO9gQncI7OtwlEHPPDbcru1
         qm3w==
X-Gm-Message-State: AGi0Puahm07Ic5PCq2GNVe2we2PFXsfAb/iDH0vceuv7VtbPheFgUACj
        uUfk1obfpjAtvo/loTC2sl0=
X-Google-Smtp-Source: APiQypIRb0Wzi2LWy8v0BRKXYlawkazyiLiR4WYqeAKtbG7btR+Rp71LHassaloIwListT0Fh/qoPA==
X-Received: by 2002:a63:296:: with SMTP id 144mr8367864pgc.110.1587225775161;
        Sat, 18 Apr 2020 09:02:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id b2sm20832321pgg.77.2020.04.18.09.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:02:54 -0700 (PDT)
Subject: Re: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-2-johannes.thumshirn@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <de79e1ab-0407-205e-3272-532f0484b49f@acm.org>
Date:   Sat, 18 Apr 2020 09:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417121536.5393-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-04-17 05:15, Johannes Thumshirn wrote:
> @@ -1190,6 +1190,7 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
>  		struct request *req)
>  {
>  	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
> +	blk_status_t ret;
>  
>  	if (!blk_rq_bytes(req))
>  		cmd->sc_data_direction = DMA_NONE;
> @@ -1199,9 +1200,14 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
>  		cmd->sc_data_direction = DMA_FROM_DEVICE;
>  
>  	if (blk_rq_is_scsi(req))
> -		return scsi_setup_scsi_cmnd(sdev, req);
> +		ret = scsi_setup_scsi_cmnd(sdev, req);
>  	else
> -		return scsi_setup_fs_cmnd(sdev, req);
> +		ret = scsi_setup_fs_cmnd(sdev, req);
> +
> +	if (ret != BLK_STS_OK)
> +		scsi_free_sgtables(cmd);
> +
> +	return ret;
>  }

If this patch fixes the bug reported in
https://bugzilla.kernel.org/show_bug.cgi?id=205595, please mention this.

How about adding __must_check to scsi_setup_fs_cmnd()?

Thanks,

Bart.
