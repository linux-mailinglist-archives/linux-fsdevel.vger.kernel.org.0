Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5012F936
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgACOaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 09:30:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727543AbgACOaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578061820;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhK5nDqlvB+sIRSPKXBkymesRttMWOxw8giPyZmb1PQ=;
        b=HYBTazvZ7ahCjYuQbrTz0t45JwLsIbnTyiTWHSuUIKxnt+0Xf4Jeu3qfKNo9Ta2KoVRpw4
        8xASgbvP5Gh0npzOGg5TQKDHKy30W4bqG8J67r6cxjMMNYcmZzeMlN1UvhEh2ZBysEVM/G
        7TfCNOAtHWeTB64Q8aMFYBhUQrwWC6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-FMDEIzQdMBiFS42WJCZe4A-1; Fri, 03 Jan 2020 09:30:17 -0500
X-MC-Unique: FMDEIzQdMBiFS42WJCZe4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF32B8024DD;
        Fri,  3 Jan 2020 14:30:15 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD74A843DA;
        Fri,  3 Jan 2020 14:30:14 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [RFC 1/9] lib/string: Add function to trim duplicate WS
From:   Tony Asleson <tasleson@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-2-tasleson@redhat.com>
 <20191223232824.GB31820@bombadil.infradead.org>
 <8392b726-fa55-baa4-6913-5ca0e4fa46a7@redhat.com>
Organization: Red Hat
Message-ID: <1e22cee9-3fda-a548-57e3-910c5a79d6ba@redhat.com>
Date:   Fri, 3 Jan 2020 08:30:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8392b726-fa55-baa4-6913-5ca0e4fa46a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/2/20 4:52 PM, Tony Asleson wrote:
> On 12/23/19 5:28 PM, Matthew Wilcox wrote:
>> On Mon, Dec 23, 2019 at 04:55:50PM -0600, Tony Asleson wrote:
>>> +/**
>>> + * Removes leading and trailing whitespace and removes duplicate
>>> + * adjacent whitespace in a string, modifies string in place.
>>> + * @s The %NUL-terminated string to have spaces removed
>>> + * Returns the new length
>>> + */
>>
>> This isn't good kernel-doc.  See Documentation/doc-guide/kernel-doc.rst
>> Compile with W=1 to get the format checked.
> 
> Indeed, I'll correct it.
> 
>>> +size_t strim_dupe(char *s)
>>> +{
>>> +	size_t ret = 0;
>>> +	char *w = s;
>>> +	char *p;
>>> +
>>> +	/*
>>> +	 * This will remove all leading and duplicate adjacent, but leave
>>> +	 * 1 space at the end if one or more are present.
>>> +	 */
>>> +	for (p = s; *p != '\0'; ++p) {
>>> +		if (!isspace(*p) || (p != s && !isspace(*(p - 1)))) {
>>> +			*w = *p;
>>> +			++w;
>>> +			ret += 1;
>>> +		}
>>> +	}
>>
>> I'd be tempted to do ...
>>
>> 	size_t ret = 0;
>> 	char *w = s;
>> 	bool last_space = false;
>>
>> 	do {
>> 		bool this_space = isspace(*s);
>>
>> 		if (!this_space || !last_space) {
>> 			*w++ = *s;
>> 			ret++;
>> 		}
>> 		s++;
>> 		last_space = this_space;
>> 	} while (s[-1] != '\0');
> 
> That leaves a starting and trailing WS, how about something like this?
> 
> size_t strim_dupe(char *s)
> {
> 	size_t ret = 0;
> 	char *w = s;
> 	bool last_space = false;
> 
> 	do {
> 		bool this_space = isspace(*s);
> 		if (!this_space || (!last_space && ret)) {Mollie Fitzgerald
> 			*w++ = *s;
> 			ret++;
> 		}
> 		s++;
> 		last_space = this_space;
> 	} while (s[-1] != '\0');
> 
> 	if (ret > 1 && isspace(w[-2])) {
> 		w[-2] = '\0';
> 		ret--;
> 	}
> 
> 	ret--;
> 	return ret;
> }

This function was added so I could strip out extra spaces in the vpd
0x83 string representation, to shorten them before they get added to the
structured syslog message.  I'm starting to think this is a bad idea as
anyone that might want to write some code to use the kernel sysfs entry
for a device and search for it in the syslog would have to perturb the
id string the same way.

I think this change should just be removed from the patch series and
leave the IDs as they are.

If we really wanted a shorter ID, a better approach would be use a hash
of the ID string, but that introduces another level of complexity that
isn't helpful to end users.

-Tony

