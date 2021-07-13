Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30BB3C6781
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 02:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhGMAiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 20:38:08 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:50992 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGMAiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 20:38:08 -0400
Received: by mail-pj1-f52.google.com with SMTP id cu14so5802690pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 17:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+YMPCvYqJ/BYZz6B5SUu4HbZdV7QYvI4oWyTUQc9zIY=;
        b=SkE6WvmCbO9jshA7miamqn4WPMWF0FqOE6X8rphb2T5Eaacp+JE2pxa2MaTU3Mo+Sb
         jiobiZ4TD8UeewQ3UmDvJV5taUZXc74BO05zKq64YE0Y1a3sggRDynTm+vPVIwB421Vc
         7maeBBDl7rk1T7u4Fm6tUJKHFJTlZF8Osp+yRHZQW0ZAq8dAAo//SUONlq0y1iD4gd+v
         KdjJMRdgqZLBESrg0ahaOx3+bGzMluKPc0M3wBqK3MpUPi8hwIyPpPyXqL1tlOU4QKRP
         uaQGUVVPZgrDcSnu/6/+LZyCmsDAoNXik9T0LLMnVGLImO4GWAZg4hc7ks524L9RNZZX
         ZUVw==
X-Gm-Message-State: AOAM531hQWMgEFtB6qbplO+QHJ5aoOJ8Z+IOb+2Ohe5/ZDyiashnl0RY
        TpjMSVrzt6pFFuoOrtIYVWE=
X-Google-Smtp-Source: ABdhPJyYhEDoEr98kYos2I5Oqs6VuLVT8+vOqg/QfNrcHjtT59yi1moi2mbhQcy4ibRCo1y475f/hw==
X-Received: by 2002:a17:902:ec86:b029:129:ab4e:9ab2 with SMTP id x6-20020a170902ec86b0290129ab4e9ab2mr1462177plg.12.1626136518980;
        Mon, 12 Jul 2021 17:35:18 -0700 (PDT)
Received: from ?IPv6:2620:0:1000:2004:de7e:1be0:8ffb:9318? ([2620:0:1000:2004:de7e:1be0:8ffb:9318])
        by smtp.gmail.com with ESMTPSA id g9sm13771885pfr.133.2021.07.12.17.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 17:35:18 -0700 (PDT)
Subject: Re: [5.14-rc1 regression] 7fe1e79b59ba configfs: implement the
 .read_iter and .write_iter methods - affects targetcli restore
To:     Yanko Kaneti <yaneti@declera.com>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <9e3b381a04fd7f7dfbf5e2395d127ab4ef554f99.camel@declera.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <070508e7-d7d1-cec7-8dda-28dca3dc2f63@acm.org>
Date:   Mon, 12 Jul 2021 17:35:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e3b381a04fd7f7dfbf5e2395d127ab4ef554f99.camel@declera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/21 12:10 PM, Yanko Kaneti wrote:
> Bisected a problem that I have with targetcli restore to:
> 
> 7fe1e79b59ba configfs: implement the .read_iter and .write_iter methods
> 
> With it reads of /sys/kernel/config/target/dbroot  go on infinitely,
> returning  the config value over and over again.
> 
> e.g.
> 
> $ modprobe target_core_user
> $ head -n 2 /sys/kernel/config/target/dbroot
> /etc/target
> /etc/target
> 
> Don't know if that's a problem with the commit or the target code, but
> could perhaps be affecting other places.

The dbroot show method looks fine to me:

static ssize_t target_core_item_dbroot_show(struct config_item *item,
					    char *page)
{
	return sprintf(page, "%s\n", db_root);
}

Anyway, I can reproduce this behavior. I will take a look at this.

Bart.
