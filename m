Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B481715BFB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgBMNtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:49:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39764 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgBMNto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:49:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so6664321ljg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNtbQDHg/1sgCok+ZoyzFMgx8nfnfEj3ekrfeoboK7M=;
        b=xHqVFMsvr5CaA5cCzOxgXJ2VcHKzsWk9DQReJ+86GD4Dp1N92v81IFCyDES9qa13qt
         0QA7jNkUmWImbgt5K2OxYuBW+pC7fCqnqJWpVewmIuUSGumSOOfq5aZVarFqllqvY8ec
         SflFEYjxvjX4PtnA8affQvBnWV3NXj2UKh+T7MzeW/S4OHyPOPm3RUjjolP1VBkGZHT0
         d4d4TTtU20gMCEVOPH+QA38dyHNQVeakBz97aNF1wskIC6P32cOH+7oXcaJMwi8afDeZ
         TeLRhdKYeIs38F0sAQBwe+QWE4ZcV5a9POlRhPlpDVXl7rBFB4v9u4Kc2kCFHQ61EIZh
         iYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNtbQDHg/1sgCok+ZoyzFMgx8nfnfEj3ekrfeoboK7M=;
        b=FSCAmx4HTWxE2fAsVZHugA8QVWk2vzhfwQ3JaI3NgAC8LvouxJdnisHPyMXRyAsr8h
         Y6mbGriSGP9/KjiTKzJNedHC+tfc3nPhtN5kyTSomnltP7jhV3yraCPmYw3awrAQsUnN
         OJXm9ipyoehLVeG3mc5w77g03DecgDLPhtvRZIho1+EhlJzgNrYcec0OPPpgZ0zkvqs9
         YQGrA6vGlwhPyOY5JTfBG1DSnnqr/7eJeMyNYl4XXRdH+J58Rm0jgumhZ+XM6N9p4KnC
         m590RN0m1O7A2ufGeaeXgDxWRX86Gxs0OcLJE+zVEAybKa0306XJw5jEsncKPbHkX9LV
         0HGQ==
X-Gm-Message-State: APjAAAULA53p3JV9/lmfHG7/qr16TrbcTTGxaz8J/hcZXOuCmbquRo7s
        lX2LxEL2eLDSXQNowiJIlaBXkw==
X-Google-Smtp-Source: APXvYqyou1s4pqXdt5G8dZ+HFYGcNZy3XmUPG5ZPsqXV80/GAjdhKPzcPHv9pUcIVyNzhnx+59OOvg==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr11652827ljh.211.1581601782160;
        Thu, 13 Feb 2020 05:49:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m83sm1347841lfa.5.2020.02.13.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:49:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4BBE8100F25; Thu, 13 Feb 2020 16:50:03 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:50:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Message-ID: <20200213135003.5dedunhnsqw5vz7d@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-3-willy@infradead.org>
 <20200212074105.GE7068@infradead.org>
 <20200212130200.GC7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212130200.GC7778@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:02:00AM -0800, Matthew Wilcox wrote:
> Would this help?

LGTM:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
