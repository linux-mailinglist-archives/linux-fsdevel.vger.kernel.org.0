Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AA1307B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAEL2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 06:28:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAEL2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:28:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so33958791wru.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 03:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OC76sMbguhzAm38TnoRGsd+QDL7twM7w/98ijOWV3G4=;
        b=owjzi9jpN6V1oUZYHv7xFf1jmqYW2uLRXZiTsRzF679hB9zwtmzQqBwsmGvGyLqA0B
         EZVnxQyUO7qicPAwMpXUIWfDYl7xDbweBTBwgm7oMMTWfwWv+bQmUdDs8T3RWJ7/V0Za
         bKf4jRSRy4mpQ2899mSc1Pf55gCa3M3b7cUhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OC76sMbguhzAm38TnoRGsd+QDL7twM7w/98ijOWV3G4=;
        b=lzdw2FN7sdSolk7L9BOXOdkWk572aRbOGemrGC/isSFPLOkVdp+T1DfDkTWaAJ3cyE
         DrdoParjKvRgnDTg6Mq3WT2xPEpyMoKvnmXg5TdgAxRADxBXii9XvwFXomU0zGu4tuAu
         8yhCqPVxUa4NPFqXM5rMnBD+7HpuIrTg8IMV3rs00l3EWy1Uv7gueLSd0lL1LRyG0tiY
         DSSEP9Oy/WtheLxm+Sk42VrkqnMfz9AL5mzU3aLH7V5V7k9uu5lJM4ghrhrEHbWS2n8L
         fcnjSRATQB+0tC7YyPP4hPpRszJsR2zgcydbxYR5y1++JOvBRHKl/21SHASo0XLb6K2M
         1jDQ==
X-Gm-Message-State: APjAAAWZP8hBoZtiQEIePquc5M2YI2hh/Fu3mXO/XDtxI2xkKByTEKas
        40Y23ysTMULq/0/5B4u2NvhJtQ==
X-Google-Smtp-Source: APXvYqwhtxTzoDsxv3E8oBXVYqD13Oy6DAcFih1nI7/wS5FoVA+HpxLwDE5XGyv3M9MeEL89gLYecA==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr99081676wru.122.1578223732958;
        Sun, 05 Jan 2020 03:28:52 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:e1d7])
        by smtp.gmail.com with ESMTPSA id t25sm18846404wmj.19.2020.01.05.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 03:28:52 -0800 (PST)
Date:   Sun, 5 Jan 2020 11:28:51 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] tmpfs: Add per-superblock i_ino support
Message-ID: <20200105112851.GA243208@chrisdown.name>
References: <cover.1578072481.git.chris@chrisdown.name>
 <19ff8eddfe9cbafc87e55949189704f31d123172.1578072481.git.chris@chrisdown.name>
 <CAOQ4uxjZUYNjBZKU85TMCjtBf9ear7s4yxYSZcBX6rTZoYK-Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjZUYNjBZKU85TMCjtBf9ear7s4yxYSZcBX6rTZoYK-Hg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein writes:
>Some nits. When fixed you may add:
>Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks! I'll fix these and comments on the other patches and send v4 here and 
with linux-mm/tmpfs maintainer on cc. :-)
