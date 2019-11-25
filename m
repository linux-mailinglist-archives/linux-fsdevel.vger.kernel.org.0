Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE27108A9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKYJPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 04:15:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40397 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKYJPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:15:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so14920161ljg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 01:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FcfAwDLFSNgmDLyFmP3mnRn5XPVP/dHuo5ueDN07hL8=;
        b=A8kCdasRJZBhUbUFtfqb5rMrJhY6qNfcEijrrxgkjPoeUE5M2cQ/cSebh/iOdguAYB
         8wSrm2cFQTzJbET8njVhqjivMpt+smTtDA5bfSKYqOsNdUkqXz4lolnMUheJjAnf5LVd
         j0Sz0rfYd1faPSXbjyizjLxqyTGe6WcM6s+e1UpALYOVJOBwZKHlG/jasxCvLaZTK2Po
         p+xbhoGkmYrAbHynoCLWeYk0/ZzQF/eOXjTVawRfbWB07ciCticc+gPdgP9yG2WPcs2y
         /6FfE7UxlgQH4+5R/939uPj/IcpEYlo57sLeQW3AgAJH+dEYhDkhPo6LCuwUQmnkHDps
         lOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FcfAwDLFSNgmDLyFmP3mnRn5XPVP/dHuo5ueDN07hL8=;
        b=T9+lzI8hyRgtlItF9XorXQEaamp9FXrNy/x6EEvtL+J5m29ALALIe2ULEHoSwzsx4S
         BvFE19ICp1IKn10Q7s5jmo7BppkhMfj9TdIZHweLQpjAmU3M66vWOV9QhodvwB/vP3Qs
         BW887TP8cc6WydLxmVe77JEPAxJ/X8jHUaaQ3uzLrOLUmqHnaHluCkPY5lFWxQsy2B2C
         ci5kOSbXuf0IBGlEapV9JPn2v27fYVD4+y53PVErJxuGRJrXjvU3w+1bwwlDyNmabo1Q
         p1PGN9J+PVO+qh6ijdC56V8g7dUL+JVoRRXAn0NPJm0f+f2moMiIxS1rtNs74Ul84rKZ
         AE1g==
X-Gm-Message-State: APjAAAVWtlvkRvNrF84cJ78g+l1hP5qbnbQk+t2zIpTPmt+kzw3lp83J
        8LP/6x0Q38LLB7ioulRVk0C1YQ==
X-Google-Smtp-Source: APXvYqx3omxBvBBPAeuC2qvJocDKxfyY/bfPA/SuPulk3OiGBBrujyPNMsYgSAQTEVKepMR1D/JfQg==
X-Received: by 2002:a2e:9695:: with SMTP id q21mr20770656lji.206.1574673300853;
        Mon, 25 Nov 2019 01:15:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q21sm3267727lfo.4.2019.11.25.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:14:59 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id CA1C11032C4; Mon, 25 Nov 2019 12:15:08 +0300 (+03)
Date:   Mon, 25 Nov 2019 12:15:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, cluster-devel@redhat.com,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC PATCH 3/3] gfs2: Rework read and page fault locking
Message-ID: <20191125091508.3265wtfzpoupv2lj@box>
References: <20191122235324.17245-1-agruenba@redhat.com>
 <20191122235324.17245-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122235324.17245-4-agruenba@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:53:24AM +0100, Andreas Gruenbacher wrote:
> @@ -778,15 +804,51 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> +	struct gfs2_inode *ip;
> +	struct gfs2_holder gh;
> +	size_t written = 0;

'written' in a read routine?

-- 
 Kirill A. Shutemov
