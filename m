Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31481130AF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 01:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAFAqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 19:46:00 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42234 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgAFAqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 19:46:00 -0500
Received: by mail-pg1-f179.google.com with SMTP id s64so26053573pgb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D1zMzxExRFFBA21C22v4D4Wtz47JX0XSCy26Khdqi1I=;
        b=xzV+a9TPkd1jk5vDSv5EMrEWF1CqCHCh5deIH56I4LGrkT5XXbeCQxHBQWckF+aSSn
         UXuisCk9SU88TctiDoLAOdH4YYp2yRFLqM8JVKWHaBet8bQvXfJwlFeyDYP/8yP+ncFy
         RD6atnag4bsLo9Mrcy8anE29O9jIAR9qraaIqWTK1XrwZIw85YJrDQLNoKeAdewDQxPq
         cUU1rmdBrGIqyhNSo/N7pJWncswyDb/RhFOTzLqhena5qGwGWl6PeK9dcoo77aNhxhdH
         Hm9fYhuy5BfSRO+/CR2QOHdp7fEOiCPn7tpDY/fYLMlUQYlrjenOKC4wPD4LNOeNu+bF
         oc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1zMzxExRFFBA21C22v4D4Wtz47JX0XSCy26Khdqi1I=;
        b=lU7w9dYSduuoLbW11TznMKqc2FOSLphvlpgOH5Ct7WfbYU/DcrVWClnkUtyJhqKlT+
         FYkKdeb74buyZgt1ALlRcvO1+w89xV1DTMvA3R5wFsWRO/VHkFQINiFPT4/1NVM/DPer
         BGDqLSynP1U+qlv8G61An0gDmb0T9keG6Fbd6AnPhGP9PFwzfuMl/bNpHRdW0FDMtJ+n
         U3VB5zYzcf4reRLgEyW6iD0p0uH2s85wb486COE2cW+EwO9nj9SnLZdWVKdtKrYRSk4f
         XicKcrf1g3xRhfSBO3os3jHvvfXVCfumOs7vlwIOazOEooRo5TGgRzon06vX8DBhhZlW
         6QzA==
X-Gm-Message-State: APjAAAXLkG5QcwCqyAySsr1MD/uCuVHIgAMIXBSKj80L1SqyYufUxOiO
        sEOznIZPLKM5UDfb/jikzJESvpjY4e8XQA==
X-Google-Smtp-Source: APXvYqz/gwMzJtWSw+9LIcJXDFjlMnDI8A3hh3KYnngMKCL80wNzQoL3JnRQwNiMfZ2uoqVh+fNN9g==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr82400581pfa.93.1578271559640;
        Sun, 05 Jan 2020 16:45:59 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b22sm71975480pft.110.2020.01.05.16.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 16:45:59 -0800 (PST)
Subject: Re: [PATCH] fs: move guard_bio_eod() after bio_set_op_attrs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20200105014114.4824-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d6e90cc-f75b-de72-6865-c392ab6161c7@kernel.dk>
Date:   Sun, 5 Jan 2020 17:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200105014114.4824-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/20 6:41 PM, Ming Lei wrote:
> Commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
> adds bio_truncate() for handling bio EOD. However, bio_truncate()
> doesn't use the passed 'op' parameter from guard_bio_eod's callers.
> 
> So bio_trunacate() may retrieve wrong 'op', and zering pages may
> not be done for READ bio.
> 
> Fixes this issue by moving guard_bio_eod() after bio_set_op_attrs()
> in submit_bh_wbc() so that bio_truncate() can always retrieve correct
> op info.
> 
> Meantime remove the 'op' parameter from guard_bio_eod() because it isn't
> used any more.

I'll queue this up, since the previous fix went through the block tree.

-- 
Jens Axboe

