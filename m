Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6120FAFFE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfIKPXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 11:23:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfIKPXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:23:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so18776004edv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bdRXlyq4l4A8bpgzomm6eF1x1mYYtVmO70wKMu77KXc=;
        b=poetBkUAgbyDnI3y/qa1TcPN6avL7jZvYR1xuvOR4FYgMjSzY40Ez86GbhxUHGeiuV
         OV3euIHts64HIU4Xzlj4S+3jIbtb7oDOg19eORR5vIx6G6RInuzBwciIB60mpznuxeSh
         yKBvY/OePNkSFcqk+zwRD1MpMpVVcYY1Q/bjXb7Fomelex8GuamZMdzf06WyyAD55m9J
         VnuuqSnc1+vy32kWxUhtQgIU4Hh4to4oylRr9XbWJn4dB4R2N+FXadF7FTR7TaA85m0a
         NPy0XKaEmseSM4oumr3Zb5qkaTDI/6BBRiApwIvibKuiJFeGdKJkWki4mmBwygxDeNZ8
         nFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdRXlyq4l4A8bpgzomm6eF1x1mYYtVmO70wKMu77KXc=;
        b=t0ryBz252KD/7ExIT/cXXHB6sJclXydZjauOzRkT9O5PvZzUDDjIBSsNkVkBxIhHL5
         PtAAmZKQj+oleAjlZxjsHcOCwtgL6UpnNa8H4RaIgfDV2/3KDXVql5eKnBA/w0z8AwYD
         yod6vBPDvA1OcvyQ4donnjeRBdg0LM0tNkm5Xu5s5+dFS/QD59hIW2UVq2jyBXJ0kVPr
         gzoUAHv9IZ2Bi/NjigopHmLL33mpO23WzfvMGRzMYfAkaH0uUhMfITUSxn+XIPFDARY/
         Olq/wuWkLMKZsGUhsIdwNc0mEXy4GW4T2Ym9Eps5LFpiBDlYZYAb0zypC5qJm6E7SUjF
         5+9A==
X-Gm-Message-State: APjAAAUIhGO5cUKxWC1enzu8MUoJYIWPy7t4p8G7m/Wo/8OocWt0iNQh
        SuT8V70ILZfLJKZpY9gsssjWvErsEII=
X-Google-Smtp-Source: APXvYqwYuTgslFkpD3GVu+/ZtjWa6+TgqNSXkaGo/8pTyfEMxmrTMrRhfUjxMtUOPKOTQwdqzarKOQ==
X-Received: by 2002:a50:9734:: with SMTP id c49mr37498960edb.93.1568215418672;
        Wed, 11 Sep 2019 08:23:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d24sm4264007edp.88.2019.09.11.08.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:23:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A385D10416F; Wed, 11 Sep 2019 18:23:38 +0300 (+03)
Date:   Wed, 11 Sep 2019 18:23:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: filemap_fault can lose errors
Message-ID: <20190911152338.gqqgxrmqycodfocb@box>
References: <20190911025158.GG29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911025158.GG29434@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 07:51:58PM -0700, Matthew Wilcox wrote:
> 
> If we encounter an error on a page, we can lose the error if we've
> dropped the mmap_sem while we wait for the I/O.  That can result in
> taking the fault multiple times, and retrying the read multiple times.
> Spotted by inspection.

But does the patch make any difference?

Looking into x86 code, VM_FAULT_RETRY makes it retry the fault or return
to userspace before it checks for VM_FAULT_SIGBUS bit.

-- 
 Kirill A. Shutemov
