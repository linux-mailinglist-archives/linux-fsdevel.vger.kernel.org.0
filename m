Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98B1EA607
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAOlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 10:41:04 -0400
Received: from mout.web.de ([212.227.15.4]:41143 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOlE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591022441;
        bh=GYixJJl+eyc0q3fXwyw3p+6RUj+8MkKKi7YziDYNgKs=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=VLme64G4xdV+B4m2ln4WMnxDDOFjTCE13uKFjf4dAFrPabATzS2rKi7GLfdO3EtPO
         tgMhx6eYwFa8EFPHtMMhhEYIbamoD7SDvdKZBXqILIF84meEswjnq4ZtgzNiIRa9jP
         KT1ND6ouwZLIGjEH5FYqoxylyf9zC0CcgixtevKQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvjoa-1iuhrp0Pdc-017UNL; Mon, 01
 Jun 2020 16:40:41 +0200
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH v2] afs: Fix memory leak in afs_put_sysnames()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <779b327f-b0fa-e21f-cbf6-5cadeca58581@web.de>
Date:   Mon, 1 Jun 2020 16:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HuDV7hfpr+tWrow1bafEA/tCXUy8759Rc0x0dQuEig0BH9hVc7+
 4K2TNZ1zxkgHIvOVqoCYizsP82qHOwpxh8kxg/1SST75eyX7DP2L5fNGCd5prG8aqSk9kAp
 lJCXqP4koGD2NTk0GNup3pr4LN/N3a9FciGGhjHh+9m2l6GrpWLQBO9nbrARgjyIXW/2aPd
 sOepHSrDDlN4PLfYr991g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nqZJSZQvFL4=:zRNQCrIrHifOQBYMwf/oFv
 dADWoDN7nxVf+sZtmS74WDLHLOnxKuUg8p3Rv5SnAYWfGHROf6UXo3lOoXX+UZrHfakU6rlu0
 5gnvEhuWfUvB+K1Pdscy0gFyiHZLNv0roIsjEWszHRds5o81qHi5tzaGlDhpX6H9+OVKK6MSk
 8kkhx4mMg+3aplRA0oqP+KlR9hvJo61RwVePW4yA+DACykYP0W5iPspoSEe6EER0EMK2E3U8A
 XdDE6Sq2tJEP5Z2AAW1NTYSZJMCE4hFzq3Gp5Cio3kiT5un9iFWA8MEP0A7n03j8eaButqWtd
 CRx3+MhgMKsSs03GEkl1EZuWQU4oBlIHTzG3O6F+xnOTMwgbVaI+BQZj4U0FHgww92fdA3ZXi
 8BuDtEiqRZbbWf8C8ZFjYN9cKjMHU/6TBSN2F/jZjH9AQ4tZUHAtTY2hpmu5cviYWBZIJlkbt
 kApW5dfOmXotkgbDCfZvmF9DcQD4xI+VvFfBSptjVVDt/v7mTGKDmxlHKt3mEQR1yFGPBX9Uv
 9QqdEvS1zoGJX1yx/Xof/RyGJ9m2rLqHCczEEjq+nJQalZ2ahFPpJP7786w5BrLBPfT335V25
 eDqb/mRUIExjAoWwIvTBm18ILDT8Y1epwb517M+JL1Q3lowdWJ+lljYfhmttU2aeQy6v9G89A
 Zecfx16I8904t9hDlajcRNWcdwlS7nKQFaE8aEykKNE1gAPvQKpcQc/7HrVe54MULlJuxGZUn
 ZT/e4tWI6xeGTDX8G+hTzL6Q7GW2ii3FYOWPJi0VnlTSksUEuofrWF+D+y+5e2u6mw+MA0dRB
 XawcKbiiHL0DWqao98htZg0vBTmDBWBM7vheVgBiLW4w9NF3sB1QCHDFiHug5U6U5aAVcByIg
 kyTnjhoCrsETaSnJ3C5iO47RtWuyYH8ZG5DB548/HKqZGkX7ao5gSUwQtZPy6lUd9V+OplrFm
 Z8cy16G3jt2ESPoz5Yg0fky6p/d2FqDdLqQD3rtCFoAU3jsDrJmFzX9EolHceIgpvnWOFSBBQ
 JHwzfuH2eTXYFu0k7TbyPnwsbTGk/nUy/WpPdG3wxODJzogjHzRHGdspD9MvQloQf1CrHOr4T
 mX7QPegqryFsJjW3GXbqKI0nE0NBMMt/RZbWxuWYinkXHZzo1V0E8pF1V9++GUs3hKicP6Var
 +IBdo2VmXG44SjMsSEfzgukNmUubm0i83duTuR28a9ZFJDO4iw8kmG1b6f1lAr3/WcGAsiiHh
 EF7egx/W13cyVId98
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> sysnames should be freed after refcnt being decreased to zero in
> afs_put_sysnames().

How do you think about a wording variant like the following?

   Release the sysnames object after its reference counter was decreased
   to zero.


Will it matter to mention the size of the data structure "afs_sysnames"?

Regards,
Markus
