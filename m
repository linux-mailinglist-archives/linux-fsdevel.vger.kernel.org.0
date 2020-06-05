Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123FD1EF8B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgFENMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:12:37 -0400
Received: from mout.web.de ([212.227.15.4]:53989 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgFENMg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591362731;
        bh=PMB/OrSW18U24vHIMH+Et3METPkSOFj+9A70a8Ux4Zs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gT+ZAtXvl7YqsicF708eVbWyj2AYfyesh172wH7txakNZ4b5rdqLsGRvYMb+G40iW
         hbTeEc6BIN+VybAcT/owMFcNxLqF1z24zS/uY/4j6lX2YynjZ9fNceGk18GJS6j+Ni
         fLSLHN51PbJAdHR4F7P82M/hhMtIJ1TROqVYhdd4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCqWJ-1jpkym0ZN5-009euU; Fri, 05
 Jun 2020 15:12:11 +0200
Subject: Re: block: Fix use-after-free in blkdev_get()
To:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Yan <yanaijie@huawei.com>, hulkci@huawei.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <88676ff2-cb7e-70ec-4421-ecf8318990b1@web.de>
 <5fa658bf-3028-9b5c-30cc-dbdef6bf8f7a@huawei.com>
 <20200605094353.GS30374@kadam> <2ee6f2f7-eaec-e748-bead-0ad59f4c378b@web.de>
 <20200605111039.GL22511@kadam> <63e57552-ab95-7bb4-b4f1-70a307b6381d@web.de>
 <20200605114208.GC19604@bombadil.infradead.org>
 <a050788f-5875-0115-af31-692fd6bf3a88@web.de>
 <20200605125209.GG19604@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <366e055b-6a00-662e-2e03-f72053f67ae6@web.de>
Date:   Fri, 5 Jun 2020 15:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605125209.GG19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:2BABuD30xVncECsA5KfvlPXoW/9y3FaEMMbgzZ66iyv6ud6cILX
 Ix1T7DmnnLSNQoemrBZlg7u0D2wvAmeiYQ2P6eD+9tHSPIk9BZ8dn+7Ym/olqhMyZj6lYAY
 JGxBeljS2S5V/5VjyAsFNd722rvC7lRJd3uXBJfSlZx99+PKN96ZgGYf/vROwu0VX8fpQn2
 t4FK5QTcYTPLJYMtiQVyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lq+UbXDLN+8=:dt4wju2mSFKltJy6+E5FjS
 nHC6XdSWk0DLb5q6N+KhtGzhNpGDsraZrHjytsP1WKkDE7NBpbFf0n7obITWk3p//U5FQJVki
 Bg57rWVjPrX6TPATZubDqHokaFDL0dkBfKwFUELnadMtG/z8HIKHI72kdgMYXuLNjluumyYdR
 J8EDLzb0hdCM+IoH7we6aH2RqeM6wkBRMlLH8IvhSMt4D2t/tNJ8+2JVHQ22VhljO/bItlI+K
 Vb+950OBF4H3EkO8pMXCt3OdFqO27p3mDNHSbCHqoqEsET4fVOlb4OySTfReg8hWGnNvZCIns
 0rj9uljrqvihsDiGtoCQMfmdcOkbV7OBZ8yilSW9R12Se2GJdiLOLLeVGDEzICjhcW5gnb6xI
 S1dafuuAJehUL0/eodAzzWVndVaqvbOITKGC/eS6TqM66CtmTXmNL1H0N3fXdUX4hGNC0bUEx
 ZxgreOxLU0Aee6SH8+HdEvKiXCpn6rQyu3228Sy3JAwyQhtytVTNav5bWICG+/N6AL/c/waG6
 Hm2OyX2Nh55TOi7+lxXRuJuFdr79hCLL/QdyO8JA7+ker/NTcN7Our6pczYSt9I23m3pnskNJ
 3Qcab5bjVbxoJw7ZpeFJ/9LXQJn35KPmaGBh+ujU8/cl80RNVUC4whrManCA5OpNFVOTR2sX3
 t5G8KaYlmwXRg28GcghLUtrorSaPyxnlmezAim4wtJVNXIBbMK9T3EPeS2EtvqnYmhAaLpBIp
 1K1meKk1tcUp5WQNdcS/8talNZ4+FrOdRTTLh1+3Hd8F+xyKD7CmbT+nPuLX+NYvrekyVR/kL
 2+0a3CM7EwjBcorEZd2wkroWS687cjQUgkd7T4/jFGNZuHDdZOV/CL/35fEa/cEE9RtnwJ02g
 hDA+gqKTFKi9QMxxdMrlcPk0KSy4OEJ5SgAfadSMbS/zcxLxNRu9dGeky6BDg4hp6iRedx/8L
 A2UOuLR0ZagpTbrovGHCZ5kcydGZBBoP4MXO1pHC/TQfcZBQPIwTWU6RqN0gYbLBX2aFi6Nsy
 8OFyoHPl31352H9XdmqfD6cPYrsT2zly7vYd0JtSWwScxvaBqmXe8GKvl/DOSqbJvTF5oFdeI
 C5kVBIYQ08BHTFo1jPt1DtYUt6ymQTo3LZcAyU11Y58ZAiIGLpkiSi5d/Lmy9zqoW88Df/LSz
 TmxAlXWgu3LuvlUxUfdmzwzMoYmkw2CkKRbEKw72eN2bSvTbg8Cu3vCjU+waFqbhAf+DWHgpJ
 5vkqg2iiEPjL8fyXk
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Your feedback is unhelpful

Do you find proposed spelling corrections useful?


> and you show no signs of changing it in response to the people
> who are telling you that it's unhelpful.

Other adjustments can occasionally be more challenging
besides the usual communication challenges.

Regards,
Markus
